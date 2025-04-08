{
  config,
  pkgs,
  lib,
  ...
}:
let
in
{
  imports = [ ./proxy.nix ];

  proxy.enable = true;
  proxy.hosts.jellyfin = {
    subdomain = "media";
    port = 8096;
  };

  services.jellyfin = {
    enable = true;
    group = "media";
  };

  systemd.services.jellyfin.serviceConfig = {
    MemoryMax = "2G";
    CPUQuota = "200%";
    Restart = "on-failure";
    RestartSec = "5";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      vpl-gpu-rt
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
