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

  microvm.autostart = [ "agent-sandbox" ];

  microvm.vms.agent-sandbox = {
    config = { config, pkgs, ... }: {
      # Phase 2: uncomment after age key registration
      # imports = [
      #   private.inputs.sops-nix.nixosModules.sops
      # ];

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

      networking.hostName = "agent-sandbox";

      systemd.network = {
        enable = true;
        networks."10-lan" = {
          matchConfig.Type = "ether";
          networkConfig.DHCP = "yes";
        };
      };

      services.tailscale.enable = true;

      services.openssh = {
        enable = true;
        settings.PermitRootLogin = "prohibit-password";
        hostKeys = [
          { path = "/var/lib/ssh/ssh_host_ed25519_key"; type = "ed25519"; }
          { path = "/var/lib/ssh/ssh_host_rsa_key"; type = "rsa"; bits = 4096; }
        ];
      };

      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIME9KfS6QNXn6aTH2LhbCU9O3E6OocgviMGucJ7OU/13 mail@gabrielpoca.com"
      ];

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

      virtualisation.docker.enable = true;

      networking.firewall.extraCommands = ''
        iptables -I nixos-fw 3 -p tcp -s 100.64.0.0/10 --dport 18789 -j nixos-fw-accept
        iptables -I nixos-fw 3 -p tcp -s 192.168.0.0/24 --dport 18789 -j nixos-fw-accept
      '';

      environment.systemPackages = with pkgs; [
        git curl wget jq
        nodejs_22
        gnumake cmake gcc
      ];

      environment.variables.NPM_CONFIG_PREFIX = "$HOME/.npm-global";
      environment.sessionVariables.PATH = [ "$HOME/.npm-global/bin" ];

      systemd.tmpfiles.rules = [
        "d /var/home/gabriel 0700 gabriel users -"
        "d /var/home/openclaw 0700 openclaw users -"
        "d /var/home/root 0700 root root -"
        "L+ /root - - - - /var/home/root"
      ];

      # Phase 2: uncomment after first boot and age key registration in .sops.yaml
      # sops.defaultSopsFile = "${private}/secrets/server.yaml";
      # sops.age.sshKeyPaths = [ "/var/lib/ssh/ssh_host_ed25519_key" ];
      # sops.secrets."backup_b2_account_id" = {};
      # sops.secrets."backup_b2_account_key" = {};
      # sops.secrets."microvm_restic_password" = {};
      #
      # sops.templates."restic".content = ''
      #   B2_ACCOUNT_ID=${config.sops.placeholder."backup_b2_account_id"}
      #   B2_ACCOUNT_KEY=${config.sops.placeholder."backup_b2_account_key"}
      # '';
      #
      # services.restic.backups.daily = {
      #   initialize = true;
      #   environmentFile = config.sops.templates."restic".path;
      #   passwordFile = config.sops.secrets."microvm_restic_password".path;
      #   paths = [ "/var/home/openclaw" ];
      #   repository = "b2:gabriel-docker-volumes:/agent-sandbox";
      #   pruneOpts = [ "--keep-daily 3" "--keep-weekly 2" "--keep-monthly 6" ];
      # };

      system.stateVersion = "24.11";
    };
  };
}
