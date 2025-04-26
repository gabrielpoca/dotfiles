{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/calibre.nix
    ../../modules/jellyfin.nix
    ../../modules/proxy.nix
    ../../modules/soulseek.nix
    ../../modules/picard.nix
    ../../modules/tube.nix
    ../../modules/samba.nix
    ../../modules/registry.nix
    # ../../modules/liquidation_bot.nix
    ../../modules/stacks/monitoring.nix
    ../../modules/private/media/default.nix
  ];

  home-manager.backupFileExtension = "bkp";
  home-manager.users.gabriel = import ./home.nix;
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

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

  time.timeZone = "Europe/Lisbon";

  security.sudo.wheelNeedsPassword = false;

  users.groups = {
    media = { };
  };

  users.users.gabriel = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "media"
      "docker"
    ];
    home = "/home/gabriel";
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIME9KfS6QNXn6aTH2LhbCU9O3E6OocgviMGucJ7OU/13 mail@gabrielpoca.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHBjGk/A4s4BfPn7tAtTwn5c1KDmRiUOk8GqhCWSIknA home"
    ];
  };

  environment.systemPackages = with pkgs; [
    gcc
    git
    htop
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web
    pciutils
    powertop
    wget
    neovim
    nixfmt-rfc-style
  ];

  services.openssh = {
    enable = true;
    allowSFTP = true;
  };

  services.tailscale.enable = true;

  services.jellyfin = {
    enable = true;
    group = "media";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-wrapped-6.0.36"
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # music
  metatube = {
    downloadFolder = "/srv/music";
  };

  soulseek = {
    completeFolder = "/srv/music";
    environmentFile = "/etc/secrets/soulseek";
  };

  picard.musicFolder = "/srv/music";
  smb.folders = [ "/srv/music" ];

  # backups
  services.restic.backups = {
    daily = {
      initialize = true;

      environmentFile = "/etc/secrets/restic.env";
      passwordFile = "/etc/secrets/restic_pwd";

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


  proxy.hosts.adguard = {
    subdomain = "adguard";
    port = 3000;
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
