{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.metatube;
in
{
  imports = [ ./proxy.nix ];

  options.metatube.downloadFolder = mkOption {
    type = types.str;
  };

  config = {
    proxy.enable = true;
    proxy.hosts.tube = {
      subdomain = "tube";
      port = 8081;
    };

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
  };
}
