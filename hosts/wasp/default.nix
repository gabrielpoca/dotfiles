{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/stacks/server.nix
  ];

  home-manager = {
    backupFileExtension = "bkp";
    useUserPackages = true;
    useGlobalPkgs = true;
    users.gabriel = import ./home.nix;
  };

  programs.zsh.enable = true;
  users.users.gabriel.shell = pkgs.zsh;

  networking.hostName = "wasp";

  services.resolved.enable = true;

  boot.kernel.sysctl = {
    "vm.overcommit_memory" = 1;
    "kernel.panic" = 10;
    "kernel.panic_on_oops" = 1;
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;

    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.all.log_martians" = 1;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
  };

  virtualisation.docker.enable = lib.mkForce false;

  systemd.tmpfiles.rules = [
    "d /var/lib/grafana 0755 472 472 -"
    "d /var/lib/loki 0755 10001 10001 -"
    "d /var/lib/prometheus 0755 65534 65534 -"
  ];

  k3s-cluster.enable = true;
  k3s-cluster.role = "agent";
  k3s-cluster.serverAddr = "https://100.90.90.3:6443";
  k3s-cluster.serverName = "wasp";
  k3s-cluster.nodeIp = "100.90.90.5";
  k3s-cluster.flannelIface = "tailscale0";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    extraCommands = ''
      iptables -A nixos-fw -s 10.42.0.0/16 -j nixos-fw-accept
    '';
  };

  system.stateVersion = "24.11";
}
