{ config, inputs, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  # environment.systemPackages = [
  #   inputs.caddy-patched.packages.x86_64-linux.caddy;
  # ];

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
        udhcpc.extraArgs = [ "-t" "20" ];
        enable = true;
        ssh = {
          enable = true;
          port = 22;
          authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIME9KfS6QNXn6aTH2LhbCU9O3E6OocgviMGucJ7OU/13 mail@gabrielpoca.com" ];
          # sudo ssh-keygen -t ed25519 -f /etc/secrets/initrd/ssh_host_ed25519_key
          hostKeys = ["/etc/secrets/initrd/ssh_host_ed25519_key"];
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
    media = {};
  };

  users.users.gabriel = {
    isNormalUser = true;
    extraGroups = ["wheel"  "media"];
    home = "/home/gabriel";
    packages = with pkgs; [
      tree
    ];

    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIME9KfS6QNXn6aTH2LhbCU9O3E6OocgviMGucJ7OU/13 mail@gabrielpoca.com" ];
  };


  environment.systemPackages = with pkgs; [
    # inputs.caddy-patched.packages.x86_64-linux.caddy
    gcc
    git
    htop
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web
    pciutils
    powertop
    wget
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  services.openssh.enable = true;

  services.tailscale.enable = true;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group="media";
  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e" ];
      hash = "sha256-JoujVXRXjKUam1Ej3/zKVvF0nX97dUizmISjy3M3Kr8=";
    };
    virtualHosts."media.gabrielpoca.com".extraConfig = ''
      reverse_proxy http://0.0.0.0:8096

      tls {
	      dns cloudflare {env.CF_API_TOKEN}
      }
    '';
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = ["/etc/secrets/caddy"];
  systemd.services.caddy.serviceConfig.AmbientCapabilities = "CAP_NET_BIND_SERVICE";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      libvdpau-va-gl
      vpl-gpu-rt          # for newer GPUs on NixOS >24.05 or unstable
    ];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
