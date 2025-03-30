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
  proxy.hosts.bazarr = {
    subdomain = "bazarr";
    port = 6767;
  };

  services.bazarr = {
    enable = true;
    group = "media";
  };
}
