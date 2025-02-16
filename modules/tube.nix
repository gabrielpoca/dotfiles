{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.metatube;
  mkVHost = import ../lib/mkVirtualHost.nix;
in
{
  options.metatube.downloadFolder = mkOption {
    type = types.str;
  };

  config = {
    virtualisation.oci-containers = {
      backend = "docker";
      containers = {
        metatube = {
          image = "ghcr.io/alexta69/metube";
          ports = [
            "8081:8081"
          ];
          volumes = [
            "${cfg.downloadFolder}:/downloads:rw"
          ];
          environment = {
            HTTPS = "false";
          };
        };
      };
    };

    services.caddy.virtualHosts = lib.mkMerge [
      (mkVHost {
        subdomain = "tube";
        port = 8081;
      })
    ];
  };
}
