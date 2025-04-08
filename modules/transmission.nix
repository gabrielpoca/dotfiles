{
  config,
  pkgs,
  lib,
  ...
}:
let
in
{
  imports = [ ./proxy.nix ];

  proxy.enable = true;
  proxy.hosts.torrents = {
    subdomain = "torrents";
    port = 9091;
  };

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

  systemd.services.transmission.serviceConfig = {
    Restart = "on-failure";
    RestartSec = "5";
  };
}
