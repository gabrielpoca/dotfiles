{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.soulseek;
  mkVHost = import ../lib/mkVirtualHost.nix;
in
{
  imports = [ ./proxy.nix ];

  options.soulseek.completeFolder = mkOption {
    type = types.str;
  };

  options.soulseek.environmentFile = mkOption {
    type = types.str;
  };

  options.soulseek.incompleteFolder = mkOption {
    type = types.str;
    default = "/var/lib/soulseek/incomplete";
  };

  options.soulseek.configFolder = mkOption {
    type = types.str;
    default = "/var/lib/soulseek/config";
  };

  config = {
    proxy.enable = true;
    proxy.hosts.soulseek = {
      subdomain = "soulseek";
      port = 5030;
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/soulseek 0770 gabriel media -"
    ];

    virtualisation.oci-containers = {
      backend = "docker";
      containers = {
        slskd = {
          image = "slskd/slskd:latest";
          ports = [
            "5030:5030"
          ];
          volumes = [
            "${cfg.completeFolder}:${cfg.completeFolder}"
            "${cfg.configFolder}:/app"
            "${cfg.incompleteFolder}:${cfg.incompleteFolder}"
          ];

          environment = {
            SLSKD_FILE_PERMISSION_MODE = "777";
            SLSKD_REMOTE_CONFIGURATION = "true";
            SLSKD_DOWNLOADS_DIR = cfg.completeFolder;
            SLSKD_INCOMPLETE_DIR = cfg.incompleteFolder;
            SLSKD_UPLOAD_SLOTS = "1";
          };

          environmentFiles = [ cfg.environmentFile ];
        };
      };
    };
  };
}
