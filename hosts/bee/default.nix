{
  pkgs,
  config,
  ...
}:
let
in
{
  users.users.deploy = {
    isNormalUser = true;
    group = "media";
    extraGroups = [ "media" ];
  };

  imports = [
    ./hardware-configuration.nix
    ../../modules/jellyfin.nix
    ../../modules/soulseek.nix
    ../../modules/picard.nix
    ../../modules/samba.nix
    ../../modules/registry.nix
    ../../modules/stacks/server.nix
    ../../modules/stacks/monitoring.nix
  ];

  systemd.tmpfiles.rules = [
    "d /srv/music 0775 gabriel media -"
    "d /srv/tvshows 0775 gabriel media -"
    "d /srv/moives 0775 gabriel media -"
    "d /srv/musicinbox 0775 gabriel media -"
  ];

  home-manager = {
    backupFileExtension = "bkp";
    useUserPackages = true;
    useGlobalPkgs = true;
    users.gabriel = import ./home.nix;
  };

  programs.zsh.enable = true;
  users.users.gabriel.shell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_testing;

    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelParams = [ "ip=dhcp" ];

    initrd = {
      availableKernelModules = [ "r8169" ];

      network = {
        postCommands = ''
          # Automatically ask for the password on SSH login
          echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
        '';
        udhcpc.extraArgs = [
          "-t"
          "20"
        ];
        enable = true;
        ssh = {
          enable = true;
          port = 22;
          authorizedKeys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIME9KfS6QNXn6aTH2LhbCU9O3E6OocgviMGucJ7OU/13 mail@gabrielpoca.com"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHBjGk/A4s4BfPn7tAtTwn5c1KDmRiUOk8GqhCWSIknA home"
          ];
          # sudo ssh-keygen -t ed25519 -f /etc/secrets/initrd/ssh_host_ed25519_key
          hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
        };
      };

      luks.devices = {
        crypted = {
          device = "/dev/nvme0n1p2";
          preLVM = true;
        };
      };
    };
  };

  networking.hostName = "bee";

  users.groups = {
    media = { };
  };

  users.users.gabriel = {
    extraGroups = [ "media" ];
  };

  environment.systemPackages = with pkgs; [
    pciutils
    powertop
    nixfmt-rfc-style
  ];

  soulseek = {
    completeFolder = "/srv/musicinbox";
    sharesFolder = "/srv/music";
  };

  picard.musicFolder = "/srv/music";

  smb.folders = [
    "/srv/music"
    "/srv/musicinbox"
  ];

  services.cloudflared = {
    enable = true;
    tunnels = {
      bee = {
        default = "http_status:404";
        credentialsFile = config.sops.secrets."cloudflared_tunnel".path;
      };
    };
  };

  sops.templates."restic".content = ''
    B2_ACCOUNT_ID=${config.sops.placeholder."backup_b2_account_id"}
    B2_ACCOUNT_KEY=${config.sops.placeholder."backup_b2_account_key"}
  '';

  # backups
  services.restic.backups = {
    daily = {
      initialize = true;

      environmentFile = config.sops.templates."restic".path;
      passwordFile = config.sops.secrets."restic_password".path;

      paths = [
        "/srv/books"
        "/srv/music"
      ];

      repository = "b2:gabriel-docker-volumes:/bee";

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };

  proxy.enable = true;
  proxy.ip = "100.90.90.3";
  proxy.hosts.adguard = {
    subdomain = "adguard";
    port = 3000;
  };

  omada.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
