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
  proxy.hosts.registry = {
    subdomain = "registry";
    port = 5000;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      registry = {
        image = "registry:2";
        ports = [
          "5000:5000"
        ];
      };
    };
  };
}
