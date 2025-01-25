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
  services.radarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts = lib.mkMerge [
    (mkVHost {
      subdomain = "radarr";
      port = 7878;
    })
  ];
}
