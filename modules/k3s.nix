{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.k3s-cluster;
in
{
  options.k3s-cluster = {
    enable = mkEnableOption "K3s Kubernetes cluster";

    role = mkOption {
      type = types.enum [ "server" "agent" ];
      default = "server";
      description = "K3s role: server (control plane) or agent (worker node)";
    };

    serverName = mkOption {
      type = types.str;
      description = "Name identifier for this k3s node";
      example = "bee";
    };

    serverAddr = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Server address for agent nodes (e.g., https://100.90.90.3:6443)";
      example = "https://100.90.90.3:6443";
    };

    tlsSan = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Additional hostname or IP to add to TLS certificate SANs (e.g., Tailscale IP)";
      example = "100.90.90.3";
    };
  };

  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = cfg.role;
      tokenFile = config.sops.secrets."k3s_token".path;

      serverAddr = mkIf (cfg.role == "agent") cfg.serverAddr;

      extraFlags = toString (
        [
          "--node-name=${cfg.serverName}"
          "--node-label=node.kubernetes.io/server=${cfg.serverName}"
          "--write-kubeconfig-mode=644"
        ]
        ++ lib.optional (cfg.tlsSan != null) "--tls-san=${cfg.tlsSan}"
      );
    };

    networking.firewall.allowedTCPPorts = [
      6443  # K3s API server
    ];

    environment.systemPackages = with pkgs; [
      k3s
      kubectl
    ];
  };
}
