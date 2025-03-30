{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
cfg = config.proxy;
mkVHost = import ../lib/mkVirtualHost.nix;
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
        plugins = [ "github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e" ];
        hash = "sha256-JoujVXRXjKUam1Ej3/zKVvF0nX97dUizmISjy3M3Kr8=";
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

    networking.firewall.allowedTCPPorts = [80 443];

    # services.caddy.virtualHosts = lib.mkMerge (
    #   mapAttrsToList (name: hostCfg:
    #     mkVHost {
    #       subdomain = hostCfg.subdomain;
    #       port = hostCfg.port;
    #     }
    #   ) cfg.hosts
    # );

    # services.caddy.virtualHosts = lib.mkMerge (
    #   mapAttrsToList (name: hostCfg:
    #     "${hostCfg.subdomain}.gabrielpoca.com" = {
    #       extraConfig = ''
    #         reverse_proxy http://localhost:${toString hostCfg.port}

    #         tls {
    #           dns cloudflare {env.CF_API_TOKEN}
    #         }
    #       '';
    #     };
    #   ) cfg.hosts
    # );

    services.adguardhome.enable = true;
    services.adguardhome.settings.filtering.rewrites =
      mapAttrsToList (name: hostCfg: {
        domain = "${hostCfg.subdomain}.gabrielpoca.com";
        answer = "100.90.90.3";
      }) cfg.hosts;
  };
}
