{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.k3s-cluster;

  admissionConfig = pkgs.writeText "admission-config.yaml" ''
    apiVersion: apiserver.config.k8s.io/v1
    kind: AdmissionConfiguration
    plugins:
      - name: PodSecurity
        configuration:
          apiVersion: pod-security.admission.config.k8s.io/v1
          kind: PodSecurityConfiguration
          defaults:
            enforce: "baseline"
            enforce-version: "latest"
            warn: "restricted"
            warn-version: "latest"
          exemptions:
            namespaces:
              - kube-system
  '';
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

    nodeIp = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Node IP address (use Tailscale IP for cross-node networking)";
      example = "100.90.90.3";
    };

    flannelIface = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Interface for Flannel traffic (use tailscale0 for Tailscale networking)";
      example = "tailscale0";
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
          "--resolv-conf=/run/systemd/resolve/resolv.conf"
          "--protect-kernel-defaults"
        ]
        ++ lib.optionals (cfg.role == "server") [
          "--write-kubeconfig-mode=600"
          "--secrets-encryption"
          "--kube-apiserver-arg=admission-control-config-file=${admissionConfig}"
        ]
        ++ lib.optional (cfg.tlsSan != null) "--tls-san=${cfg.tlsSan}"
        ++ lib.optional (cfg.nodeIp != null) "--node-ip=${cfg.nodeIp}"
        ++ lib.optional (cfg.flannelIface != null) "--flannel-iface=${cfg.flannelIface}"
      );
    };

    networking.firewall.allowedTCPPorts = lib.mkIf (cfg.role == "server") [
      6443
    ];

    environment.systemPackages = with pkgs; [
      k3s
      kubectl
    ];
  };
}
