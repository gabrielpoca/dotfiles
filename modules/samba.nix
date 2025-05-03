{
  config,
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
          "create mask" = "0775";
          "directory mask" = "0775";
          "server role" = "standalone";
          "guest account" = "nobody";
          "map to guest" = "bad user";
          "security" = "auto";
          "socket options" = "TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072";
          "min receivefile size" = "16384";
          "use sendfile" = "yes";
          "aio read size" = "16384";
          "aio write size" = "16384";
          "read raw" = "yes";
          "write raw" = "yes";
          "getwd cache" = "yes";
          "unix extensions" = "no";
          "follow symlinks" = "yes";
        };
      };

      shares = builtins.listToAttrs (map
        (folder: {
          name = baseNameOf folder;
          value = {
            path = folder;
            public = true;
            writable = true;
            "guest ok" = "yes";
            "guest only" = "yes";
          };
        })
        cfg.folders);
    };
  };
}
