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
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      stremio = {
        image = "stremio/server:latest";
        ports = [
          "11470:11470"
          "8080:8080"
        ];
        volumes = [ "/var/lib/stremio/:/usr/app/data/" ];
        devices = [
          "/dev/dri/card0:/dev/dri/card0"
          "/dev/dri/renderD128:/dev/dri/renderD128"
        ];
        environment = {
          NO_CORS = "1";
          FFMPEG_BIN = "/run/current-system/sw/bin/";
          FFPROBE_BIN = "/run/current-system/sw/bin/";
          CASTING_DISABLED = "0";
        };
      };
    };
  };

  services.caddy.virtualHosts = lib.mkMerge [
    (mkVHost {
      subdomain = "stremio";
      port = 11470;
    })
  ];
}
