{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.smb;
in
{
  options.smb = {
    folders = mkOption {
      type = types.listOf types.str;
      description = "List of folder paths to share via Samba";
      default = [];
      example = [ "/mnt/media" "/mnt/downloads" ];
    };
  };

  config = {
    services.samba = {
      enable = true;

      settings = {
        global = {
          "map to guest" = "Bad User";
          "guest account" = "nobody";
          "usershare allow guests" = "yes";
        };
      };

      shares = builtins.listToAttrs (map
        (folder: {
          name = baseNameOf folder;
          value = {
            path = folder;
            browseable = "yes";
            "guest ok" = "yes";
            "public" = "yes";
            "writable" = "yes";
            "guest only" = "yes";
            "force user" = "nobody";
          };
        })
        cfg.folders);
    };
  };
}
