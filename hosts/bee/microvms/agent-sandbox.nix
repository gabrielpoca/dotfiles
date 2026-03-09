{ config, lib, pkgs, microvm, private, ... }:
{
  imports = [ microvm.nixosModules.host ];

  networking.useNetworkd = true;
  services.resolved.fallbackDns = [ "8.8.8.8" "1.1.1.1" ];

  systemd.network.netdevs."10-br-agent" = {
    netdevConfig = {
      Name = "br-agent";
      Kind = "bridge";
      MACAddress = "none";
    };
  };

  systemd.network.networks."10-enp1s0" = {
    matchConfig.Name = "enp1s0";
    networkConfig.Bridge = "br-agent";
  };

  systemd.network.networks."20-br-agent" = {
    matchConfig.Name = "br-agent";
    networkConfig.DHCP = "yes";
    networkConfig.ConfigureWithoutCarrier = true;
  };

  systemd.network.networks."50-microvm" = {
    matchConfig.Name = "vm-*";
    networkConfig.Bridge = "br-agent";
  };

  systemd.network.networks."99-k3s-ignore" = {
    matchConfig.Name = "cni* flannel* veth*";
    linkConfig.Unmanaged = true;
  };

  networking.firewall.extraCommands = ''
    iptables -I FORWARD -i vm-agent -d 10.43.0.0/16 -j DROP
    iptables -I FORWARD -i vm-agent -d 10.42.0.0/16 -j DROP
    iptables -I INPUT 1 -s 100.90.90.6 -p tcp --dport 30000:32767 -j DROP
  '';

  microvm.autostart = [ "agent-sandbox" ];

  microvm.vms.agent-sandbox = {
    config = { config, pkgs, ... }: {
      imports = [
        private.inputs.sops-nix.nixosModules.sops
      ];

      microvm = {
        hypervisor = "cloud-hypervisor";
        vcpu = 2;
        mem = 4096;

        interfaces = [{
          type = "tap";
          id = "vm-agent";
          mac = "02:00:00:00:00:01";
        }];

        volumes = [{
          image = "var.img";
          mountPoint = "/var";
          size = 65536;
        }];

        writableStoreOverlay = "/var/nix/.rw-store";
      };

      fileSystems."/" = {
        device = "none";
        fsType = "tmpfs";
        options = [ "mode=755" "size=2G" ];
      };

      fileSystems."/var/home/openclaw/.openclaw/workspace/obsidian" = {
        device = "/var/home/openclaw/.openclaw/obsidian";
        options = [ "bind" ];
      };

      fileSystems."/var/home/openclaw/.openclaw/workspace-cooking/obsidian" = {
        device = "/var/home/openclaw/.openclaw/obsidian";
        options = [ "bind" ];
      };

      networking.hostName = "agent-sandbox";

      systemd.network = {
        enable = true;
        networks."10-lan" = {
          matchConfig.MACAddress = "02:00:00:00:00:01";
          networkConfig.DHCP = "yes";
        };
      };

      services.tailscale.enable = true;

      services.openssh = {
        enable = true;
        settings.PermitRootLogin = "no";
        hostKeys = [
          { path = "/var/lib/ssh/ssh_host_ed25519_key"; type = "ed25519"; }
          { path = "/var/lib/ssh/ssh_host_rsa_key"; type = "rsa"; bits = 4096; }
        ];
      };


      users.users.gabriel = {
        isNormalUser = true;
        home = "/var/home/gabriel";
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIME9KfS6QNXn6aTH2LhbCU9O3E6OocgviMGucJ7OU/13 mail@gabrielpoca.com"
        ];
      };

      users.users.openclaw = {
        isNormalUser = true;
        home = "/var/home/openclaw";
        extraGroups = [ "docker" ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIME9KfS6QNXn6aTH2LhbCU9O3E6OocgviMGucJ7OU/13 mail@gabrielpoca.com"
        ];
      };

      security.sudo.wheelNeedsPassword = false;

      zramSwap.enable = true;

      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          libcap
          openssl
          xz
          zlib
        ];
      };

      virtualisation.docker.enable = true;

      systemd.services.openclaw-gateway = {
        description = "OpenClaw Gateway";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.nodejs_22 ];
        serviceConfig = {
          ExecStart = "/var/home/openclaw/.npm-global/bin/openclaw gateway --port 18789";
          Restart = "always";
          RestartSec = 5;
          User = "openclaw";
          Group = "users";
          WorkingDirectory = "/var/home/openclaw";
          Environment = [
            "HOME=/var/home/openclaw"
            "PATH=/var/home/openclaw/.npm-global/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin"
          ];
          UMask = "0027";
        };
      };

      networking.firewall.extraCommands = ''
        iptables -I nixos-fw 3 -p tcp -s 100.64.0.0/10 --dport 18789 -j nixos-fw-accept
        iptables -I nixos-fw 3 -p tcp -s 192.168.0.0/24 --dport 18789 -j nixos-fw-accept
      '';

      systemd.services.livesync-bridge = {
        description = "LiveSync Bridge";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.deno pkgs.git pkgs.jq ];
        serviceConfig = {
          ExecStartPre = pkgs.writeShellScript "livesync-bridge-setup" ''
            if [ ! -d /var/home/openclaw/livesync-bridge ]; then
              git clone --recursive https://github.com/vrtmrz/livesync-bridge /var/home/openclaw/livesync-bridge
            fi
            mkdir -p /var/home/openclaw/livesync-bridge/dat
            rm -f /var/home/openclaw/livesync-bridge/dat/config.json
            cat ${config.sops.templates."livesync-bridge".path} > /var/home/openclaw/livesync-bridge/dat/config.json
            jq 'del(.imports.trystero)' /var/home/openclaw/livesync-bridge/deno.jsonc > /tmp/deno.jsonc \
              && cp /tmp/deno.jsonc /var/home/openclaw/livesync-bridge/deno.jsonc
            cd /var/home/openclaw/livesync-bridge && ${pkgs.deno}/bin/deno install --allow-import
            cat > /var/home/openclaw/livesync-bridge/node_modules/.deno/pouchdb-fetch@9.0.0/node_modules/pouchdb-fetch/lib/index.js << 'EOF'
'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
exports.fetch = globalThis.fetch.bind(globalThis);
exports.Headers = globalThis.Headers;
EOF
          '';
          ExecStart = pkgs.writeShellScript "livesync-bridge-run" ''
            cd /var/home/openclaw/livesync-bridge
            exec ${pkgs.deno}/bin/deno task run
          '';
          Restart = "always";
          RestartSec = 10;
          User = "openclaw";
          Group = "users";
          Environment = "HOME=/var/home/openclaw";
        };
      };

      environment.systemPackages = let
        gh-wrapped = pkgs.writeShellScriptBin "gh" ''
          APP_ID=$(cat ${config.sops.secrets."github_app_id".path})
          INSTALLATION_ID=$(cat ${config.sops.secrets."github_app_installation_id".path})
          PRIVATE_KEY=${config.sops.secrets."github_app_private_key".path}

          HEADER=$(printf '{"alg":"RS256","typ":"JWT"}' | ${pkgs.openssl}/bin/openssl base64 -A | tr '+/' '-_' | tr -d '=')
          NOW=$(date +%s)
          PAYLOAD=$(printf '{"iat":%d,"exp":%d,"iss":"%s"}' $((NOW-60)) $((NOW+600)) "$APP_ID" | ${pkgs.openssl}/bin/openssl base64 -A | tr '+/' '-_' | tr -d '=')
          SIGNATURE=$(printf '%s.%s' "$HEADER" "$PAYLOAD" | ${pkgs.openssl}/bin/openssl dgst -sha256 -sign "$PRIVATE_KEY" -binary | ${pkgs.openssl}/bin/openssl base64 -A | tr '+/' '-_' | tr -d '=')
          JWT="$HEADER.$PAYLOAD.$SIGNATURE"

          export GH_TOKEN=$(${pkgs.curl}/bin/curl -sf -X POST \
            -H "Authorization: Bearer $JWT" \
            -H "Accept: application/vnd.github+json" \
            "https://api.github.com/app/installations/$INSTALLATION_ID/access_tokens" | ${pkgs.jq}/bin/jq -r '.token')

          exec ${pkgs.gh}/bin/gh "$@"
        '';
      in with pkgs; [
        git curl wget jq
        nodejs_22 deno
        gnumake cmake gcc
        gh-wrapped
      ];

      environment.variables.NPM_CONFIG_PREFIX = "$HOME/.npm-global";
      environment.sessionVariables.PATH = [ "$HOME/.npm-global/bin" ];

      systemd.tmpfiles.rules = [
        "d /var/home/gabriel 0700 gabriel users -"
        "d /var/home/openclaw 0770 openclaw users -"
        "d /var/home/openclaw/.openclaw/obsidian 0770 openclaw users -"
        "d /var/home/openclaw/.openclaw/workspace 0770 openclaw users -"
        "d /var/home/openclaw/.openclaw/workspace-cooking 0770 openclaw users -"
        "d /var/home/root 0700 root root -"
        "L+ /root - - - - /var/home/root"
      ];

      sops.defaultSopsFile = "${private}/secrets/server.yaml";
      sops.age.sshKeyPaths = [ "/var/lib/ssh/ssh_host_ed25519_key" ];
      sops.secrets."backup_b2_account_id" = {};
      sops.secrets."backup_b2_account_key" = {};
      sops.secrets."microvm_restic_password" = {};
      sops.secrets."github_app_id".mode = "0444";
      sops.secrets."github_app_installation_id".mode = "0444";
      sops.secrets."github_app_private_key".mode = "0444";
      sops.secrets."couchdb_username" = {};
      sops.secrets."couchdb_password" = {};
      sops.secrets."livesync_passphrase" = {};

      sops.templates."livesync-bridge" = {
        owner = "openclaw";
        content = ''
          {
            "peers": [
              {
                "type": "couchdb",
                "name": "obsidian",
                "url": "https://couchdb.v.gabrielpoca.com",
                "database": "obsidian-e2e",
                "username": "${config.sops.placeholder."couchdb_username"}",
                "password": "${config.sops.placeholder."couchdb_password"}",
                "passphrase": "${config.sops.placeholder."livesync_passphrase"}",
                "obfuscatePassphrase": "",
                "baseDir": "",
                "customChunkSize": 100,
                "minimumChunkSize": 20
              },
              {
                "type": "storage",
                "name": "vault",
                "baseDir": "/var/home/openclaw/.openclaw/obsidian/",
                "scanOfflineChanges": true
              }
            ]
          }
        '';
      };

      sops.templates."restic".content = ''
        B2_ACCOUNT_ID=${config.sops.placeholder."backup_b2_account_id"}
        B2_ACCOUNT_KEY=${config.sops.placeholder."backup_b2_account_key"}
      '';

      services.restic.backups.daily = {
        initialize = true;
        environmentFile = config.sops.templates."restic".path;
        passwordFile = config.sops.secrets."microvm_restic_password".path;
        paths = [ "/var/home/openclaw" ];
        repository = "b2:gabriel-docker-volumes:/agent-sandbox";
        pruneOpts = [ "--keep-daily 3" "--keep-weekly 2" "--keep-monthly 6" ];
      };

      system.stateVersion = "24.11";
    };
  };
}
