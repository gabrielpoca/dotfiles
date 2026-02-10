{ config, lib, pkgs, microvm, ... }:
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
      microvm = {
        hypervisor = "cloud-hypervisor";
        vcpu = 2;
        mem = 6144;

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

      environment.systemPackages = with pkgs; [
        git curl wget jq
        nodejs_22
        gnumake cmake gcc
      ];

      environment.variables.NPM_CONFIG_PREFIX = "$HOME/.npm-global";
      environment.sessionVariables.PATH = [ "$HOME/.npm-global/bin" ];

      systemd.tmpfiles.rules = [
        "d /var/home/root 0700 root root -"
        "L+ /root - - - - /var/home/root"
      ];

      virtualisation.docker.enable = true;

      system.stateVersion = "24.11";
    };
  };
}
