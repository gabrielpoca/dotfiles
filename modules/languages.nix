{
  pkgs,
  claude-code,
  ...
}:

{
  home.packages = with pkgs; [
    # Language runtimes
    nodejs_24
    (python313.withPackages (ps: with ps; [
      ansible
      pipenv
      neovim-remote
    ]))
    ruby_3_1
    go
    beam.packages.erlang_27.elixir_1_18
    jdk11

    # Node.js tools
    bun
    nodePackages.yarn
    nodePackages.prettier
    nodePackages.http-server

    # Claude Code
    claude-code.packages.${pkgs.system}.default
  ];
}
