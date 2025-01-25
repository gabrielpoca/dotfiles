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
  services.jackett = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts = lib.mkMerge [
    (mkVHost {
      subdomain = "jackett";
      port = 9117;
    })
  ];
}
