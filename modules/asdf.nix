{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zsh.initExtra = ''
    . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
    . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
  '';

  home.file = {
    ".default-gems" = {
      text = ''
        bundler
        pry
        gem-ctags
        neovim
        octokit
        git
        netrc
      '';
    };
    ".default-npm-packages" = {
      text = ''
        yarn
        javascript-typescript-langserver
        prettier
        neovim
        yarn
        http-server
        solc
        prettier-plugin-solidity
        solhint
        @fsouza/prettierd
        eslint_d
      '';
    };
    ".default-python-packages" = {
      text = ''
        ansible
        pipenv
        neovim-remote
      '';
    };
    ".tool-versions" = {
      text = ''
        elixir 1.16.0-rc.0-otp-26
        erlang 26.1.2
        nodejs 20.7.0
        python 3.13.1
        ruby 3.1.1
        golang 1.21.5
        java adoptopenjdk-11.0.24+8
      '';
    };
  };
}
