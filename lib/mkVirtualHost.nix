{
  subdomain,
  port,
}:
{
  "${subdomain}.gabrielpoca.com" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}

      tls {
        dns cloudflare {env.CF_API_TOKEN}
      }
    '';
  };
}
