{
  config,
  lib,
  pkgs,
  ...
}:
{
  time.timeZone = "Europe/Lisbon";

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    allowSFTP = true;
  };

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    git
    htop
    wget
    neovim
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  users.users.gabriel = {
    isNormalUser = true;
    home = "/home/gabriel";
    packages = with pkgs; [ tree ];
    extraGroups = [
      "wheel"
      "docker"
    ];
  };
}
