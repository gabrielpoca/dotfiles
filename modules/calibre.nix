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
  systemd.services.calibre-web = {
    after = [ "network.target" ];
    wants = [ "network.target" ];
    serviceConfig = {
      CacheDirectory = "calibre-web";
      Environment = [ "CACHE_DIR=/var/cache/calibre-web" ];
      Restart = "on-failure";
      RestartSec = "5";
    };
  };

  services.calibre-web = {
    enable = true;
    group = "media";
    dataDir = "/srv/books";
    listen = {
      port = 8085;
    };
    options = {
      calibreLibrary = "/srv/books";
      enableBookUploading = true;
      enableBookConversion = true;
    };
  };

  services.caddy.virtualHosts = lib.mkMerge [
    (mkVHost {
      subdomain = "books";
      port = 8085;
    })
  ];
}
