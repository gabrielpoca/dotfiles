{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
cfg = config.proxy;
in
{
  options.proxy = {
    enable = mkEnableOption "proxy";

    hosts = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          subdomain = mkOption {
            type = types.str;
            description = "The subdomain for this host";
          };
          port = mkOption {
            type = types.int;
            description = "The port to proxy";
          };
        };
      });
      default = {};
      description = "Virtual hosts configurations";
    };
  };

  config = lib.mkIf cfg.enable {
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
        hash = "sha256-Nwm4kzAmmu+UZTJB5npWdwfgoj3giHIEWIgDF6ff+dY=";
      };

      virtualHosts = lib.mapAttrs' (name: hostCfg:
        nameValuePair "${hostCfg.subdomain}.gabrielpoca.com" {
          extraConfig = ''
            reverse_proxy http://localhost:${toString hostCfg.port}

            tls {
              dns cloudflare {env.CF_API_TOKEN}
            }
          '';
        }
      ) cfg.hosts;
    };

    systemd.services.caddy.serviceConfig = {
      EnvironmentFile = [ "/etc/secrets/caddy" ];
      AmbientCapabilities = "CAP_NET_BIND_SERVICE";
      Restart = "on-failure";
    };

    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [80 443];

    services.adguardhome = {
      enable = true;
      mutableSettings = true;
      openFirewall = true;
      settings = {
        dns = {
          ratelimit = 0;
          bind_hosts = [ "0.0.0.0" ];
          upstream_dns = [
            "1.1.1.1"
            "8.8.8.8"
          ];
          bootstrap_dns = [
            "1.1.1.1"
            "8.8.8.8"
          ];
        };
      };
    };

    services.adguardhome.settings.filtering.rewrites =
      mapAttrsToList (name: hostCfg: {
        domain = "${hostCfg.subdomain}.gabrielpoca.com";
        answer = "100.90.90.3";
      }) cfg.hosts;
  };
}
