{
  config,
  pkgs,
  lib,
  ...
}:
let
in
{
  imports = [ ../../proxy.nix ];

  proxy.enable = true;
  proxy.hosts.stremio = {
    subdomain = "stremio";
    port = 11470;
  };

  networking.firewall.allowedTCPPorts = [ 11470 12470 ];
  networking.firewall.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      stremio = {
        image = "stremio/server:latest";
        pull = "always";
        ports = [
          "11470:11470"
          "12470:12470"
          "8080:8080"
        ];
        volumes = [
          "/var/lib/stremio/:/usr/app/data/"
          # "/run/current-system/sw/bin/ffmpeg:/run/current-system/sw/bin/ffmpeg:ro"
          # "/run/current-system/sw/bin/ffprobe:/run/current-system/sw/bin/ffprobe:ro"
          "/var/lib/stremio/server/:/root/.stremio-server"
        ];
        devices = [
          # "/dev/dri/card0:/dev/dri/card0"
          # "/dev/dri/renderD128:/dev/dri/renderD128"
        ];
        environment = {
          NO_CORS = "1";
          # FFMPEG_BIN = "/run/current-system/sw/bin/ffmpeg";
          # FFPROBE_BIN = "/run/current-system/sw/bin/ffprobe";
          APP_PATH = "/usr/app/data/";
        };
      };
    };
  };
}
