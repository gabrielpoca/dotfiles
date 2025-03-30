{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  mkVHost = import ../../lib/mkVirtualHost.nix;
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/calibre.nix
    ../../modules/jellyfin.nix
    ../../modules/sonarr.nix
    ../../modules/radarr.nix
    ../../modules/bazarr.nix
    ../../modules/jackett.nix
    ../../modules/transmission.nix
    ../../modules/stremio.nix
    ../../modules/proxy.nix
    ../../modules/soulseek.nix
    ../../modules/picard.nix
    ../../modules/tube.nix
    ../../modules/samba.nix
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

  services.adguardhome = {
    enable = true;
    mutableSettings = true;
    openFirewall = true;
    settings = {
      dns = {
        ratelimit = 0;
        bind_hosts = [ "0.0.0.0" ];
        upstream_dns = [
          "tls://dns.google"
          "tls://cloudflare-dns.com"
          "tls://dns.quad9.net"
        ];
        bootstrap_dns = [
          "8.8.8.8"
          "8.8.4.4"
        ];
        # bootstrap_dns = [
        #   "9.9.9.10"
        #   "149.112.112.10"
        #   "2620:fe::10"
        #   "2620:fe::fe:10"
        # ];
        # upstream_dns = [
        #   "1.1.1.1"
        #   "1.0.0.1"
        #   "8.8.8.8"
        #   "8.8.4.4"
        # ];
      };
    };
  };

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

  networking.firewall.allowedTCPPorts = [ 11470 ];
  networking.firewall.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
