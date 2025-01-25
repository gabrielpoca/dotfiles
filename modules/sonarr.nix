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
  services.sonarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts = lib.mkMerge [
    (mkVHost {
      subdomain = "sonarr";
      port = 8989;
    })
  ];
}
