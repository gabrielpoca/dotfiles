{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e" ];
      hash = "sha256-JoujVXRXjKUam1Ej3/zKVvF0nX97dUizmISjy3M3Kr8=";
    };
  };

  systemd.services.caddy.serviceConfig = {
    EnvironmentFile = [ "/etc/secrets/caddy" ];
    AmbientCapabilities = "CAP_NET_BIND_SERVICE";
    Restart = "on-failure";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
