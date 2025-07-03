{
  config,
  pkgs,
  lib,
  ...
}:
let
in
{
  proxy.hosts.jellyfin = {
    subdomain = "media";
    port = 8096;
  };

  networking.firewall.allowedTCPPorts = [
    8096
  ];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web
  ];

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

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-wrapped-6.0.36"
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];
}
