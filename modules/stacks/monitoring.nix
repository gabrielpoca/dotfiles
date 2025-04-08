
{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3001;
        domain = "grafana.gabrielpoca.com";
      };
    };
  };

  services.prometheus = {
    enable = true;
    port = 3002;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 3003;
      };
    };
    scrapeConfigs = [
      {
        job_name = "bee";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
      {
        job_name = "liquidation_bot";
        static_configs = [{
          targets = [ "127.0.0.1:3030" ];
        }];
      }
    ];
  };

  proxy.enable = true;
  proxy.hosts.grafana = {
    subdomain = "grafana";
    port = 3001;
  };

}
