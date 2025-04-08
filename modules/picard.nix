
{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.picard;
in
{
  imports = [ ./proxy.nix ];

  options.picard.musicFolder = mkOption {
    type = types.str;
  };

  options.picard.configFolder = mkOption {
    type = types.str;
    default = "/var/lib/picard";
  };

  config = {
    proxy.enable = true;
    proxy.hosts.picard = {
      subdomain = "picard";
      port = 5800;
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/picard 0770 gabriel media -"
    ];

    virtualisation.oci-containers = {
      backend = "docker";
      containers = {
        picard = {
          image = "mikenye/picard:latest";
          ports = [
            "5800:5800"
          ];
          volumes = [
            "${cfg.musicFolder}:/storage"
            "${cfg.configFolder}:/config"
          ];
        };
      };
    };
  };
}
