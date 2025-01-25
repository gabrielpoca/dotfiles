{
  config,
  pkgs,
  lib,
  ...
}:
let
  mkVHost = import ../lib/mkVirtualHost.nix;
in
{
  services.jellyfin = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts = lib.mkMerge [
    (mkVHost {
      subdomain = "media";
      port = 8096;
    })
  ];

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
