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
  imports = [ ./proxy.nix ];

  proxy.enable = true;
  proxy.hosts.sonarr = {
    subdomain = "sonarr";
    port = 8989;
  };

  services.sonarr = {
    enable = true;
    group = "media";
  };
}
