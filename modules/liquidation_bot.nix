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
  proxy.hosts.liquidation_bot = {
    subdomain = "liquidation_bot";
    port = 5000;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      liquidation_bot = {
        pull = "always";
        cmd = ["npm" "start" "hyperMainnet"];
        image = "registry.gabrielpoca.com/liquidation_bot:latest";
        volumes = [ "/var/lib/liquidation/:/app/data/" ];
        ports = [
          "3030:3030"
        ];
        environment = {
          LOG = "debug";
          PORT = "3030";
          DB_FILE_NAME = "/app/data/production.sqlite";
        };

        environmentFiles = [ "/etc/secrets/liquidation_bot" ];
      };
    };
  };
}
