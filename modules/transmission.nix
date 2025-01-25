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
  services.transmission = {
    enable = true;
    group = "media";
    settings = {
      download-dir = "/srv/downloads/complete";
      incomplete-dir = "/srv/downloads/incomplete";
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,0.0.0.0";
      rpc-host-whitelist = "torrents.gabrielpoca.com";
    };
  };

  services.caddy.virtualHosts = lib.mkMerge [
    (mkVHost {
      subdomain = "torrents";
      port = 9091;
    })
  ];

  systemd.services.transmission.serviceConfig = {
    Restart = "on-failure";
    RestartSec = "5";
  };
}
