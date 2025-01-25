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
  services.bazarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts = lib.mkMerge [
    (mkVHost {
      subdomain = "bazarr";
      port = 6767;
    })
  ];
}
