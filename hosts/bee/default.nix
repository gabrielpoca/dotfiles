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
    ../../modules/samba.nix
    ../../modules/stacks/server.nix
  ];

  systemd.tmpfiles.rules = [
    "d /srv/music 0775 gabriel media -"
    "d /srv/tvshows 0775 gabriel media -"
    "d /srv/movies 0775 gabriel media -"
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

    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

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

  smb.folders = [
    "/srv/music"
    "/srv/musicinbox"
  ];

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
        "/var/lib/rancher/k3s"
        "/var/lib/omada/data"
      ];

      repository = "b2:gabriel-docker-volumes:/bee";

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    29811
    29812
    29813
    29814
    29815
    29816
    29817
  ];
  networking.firewall.allowedUDPPorts = [
    19810
    27001
    29810
  ];

  k3s-cluster.enable = true;
  k3s-cluster.role = "server";
  k3s-cluster.serverName = "bee";
  k3s-cluster.tlsSan = "100.90.90.3";

  system.stateVersion = "24.11"; # Did you read the comment?
}
