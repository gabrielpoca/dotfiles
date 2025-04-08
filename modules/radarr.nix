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

  services.radarr = {
    enable = true;
    group = "media";
  };

  proxy.enable = true;
  proxy.hosts.radarr = {
    subdomain = "radarr";
    port = 7878;
  };
}
