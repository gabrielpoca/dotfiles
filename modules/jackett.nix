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
  proxy.hosts.jackett = {
    subdomain = "jackett";
    port = 9117;
  };

  services.jackett = {
    enable = true;
    group = "media";
  };
}
