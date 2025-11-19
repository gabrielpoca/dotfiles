{
  config,
  pkgs,
  lib,
  ...
}:
let
in
{
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

  systemd.services.registry.serviceConfig = {
    Restart = "on-failure";
  };
}
