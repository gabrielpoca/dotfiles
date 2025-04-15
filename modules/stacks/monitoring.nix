
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

    provision = {
      enable = true;

      datasources.settings = {
        apiVersion = 1;

        datasources = [
          {
            name = "Loki";
            type = "loki";
            access = "direct";
            url = "http://127.0.0.1:${toString config.services.loki.configuration.server.http_listen_port}";
            isDefault = true;
          }
          {
            name = "Prometheus";
            type = "prometheus";
            access = "proxy";
            url = "http://127.0.0.1:${toString config.services.prometheus.port}";

            jsonData = {
              manageAlerts = true;
              prometheusType = "Prometheus";
              prometheusVersion = config.services.prometheus.package.version;
              cacheLevel = "High";
            };
          }
        ];
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
          targets = [ "100.103.29.133:3030" ];
        }];
      }
    ];
  };

  services.loki = {
    enable = true;

    extraFlags = [ "-print-config-stderr" ];

    configuration = {
      auth_enabled = false;

      server = {
        http_listen_address = "0.0.0.0";
        http_listen_port = 3004;

        grpc_listen_port = 0;
      };

      ingester.lifecycler = {
        address = "127.0.0.1";

        ring = {
          kvstore.store = "inmemory";

          replication_factor = 1;
        };
      };

      # https://grafana.com/docs/loki/latest/operations/storage/schema
      schema_config = {
        configs = [{
          from = "2024-01-01";
          object_store = "filesystem";
          store = "tsdb";
          schema = "v13";
          index = {
            prefix = "index_";
            period = "24h";
          };
        }];
      };

      storage_config = {
        tsdb_shipper = {
          active_index_directory = "${config.services.loki.dataDir}/tsdb-index";
          cache_location = "${config.services.loki.dataDir}/tsdb-cache";
        };

        filesystem.directory = "${config.services.loki.dataDir}/chunks";
      };

      compactor = {
        working_directory = config.services.loki.dataDir;

        compactor_ring.kvstore.store = "inmemory";
      };

      analytics.reporting_enabled = false;
      tracing.enabled = false;
    };
  };

  proxy.enable = true;

  proxy.hosts.grafana = {
    subdomain = "grafana";
    port = 3001;
  };

  proxy.hosts.loki = {
    subdomain = "loki";
    port = 3004;
  };
}
