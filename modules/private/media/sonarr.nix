{
  config,
  pkgs,
  lib,
  ...
}:
let
in
{
  imports = [ ../../proxy.nix ];

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
