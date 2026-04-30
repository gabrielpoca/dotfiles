{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.shell.theme;
  rebuildScript = pkgs.runCommand "rebuild" { } ''
    install -D -m 755 ${../files/shell/bin/rebuild} $out/bin/rebuild
    patchShebangs $out/bin/rebuild
  '';
in
{
  options.shell.theme = mkOption {
    type = types.str;
    default = "robbyrussell";
  };

  config = {
    programs.atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        enter_accept = false;
        invert = true;
      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zsh = {
      enable = true;

      history = {
        size = 10000;
      };

      initContent = ''
        # Emit OSC 7 so terminal (wezterm) knows hostname + cwd
        _osc7_cwd() {
          local strlen=''${#PWD}
          local encoded=""
          local i c o
          for (( i = 0; i < strlen; ++i )); do
            c=''${PWD[i+1]}
            case "$c" in
              [-/_.~A-Za-z0-9]) o="$c" ;;
              *) printf -v o '%%%02X' "'$c" ;;
            esac
            encoded+="$o"
          done
          printf '\e]7;file://%s%s\e\\' "''${HOST:-$(hostname)}" "$encoded"
        }
        autoload -Uz add-zsh-hook
        add-zsh-hook chpwd _osc7_cwd
        _osc7_cwd
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "aws"
          "fzf"
          "gh"
          "mix"
          "npm"
        ];
        theme = cfg;
      };
    };

    home.sessionPath = [
      "$HOME/Developer/dotfiles/files/shell/bin"
    ];

    home.packages = [ rebuildScript ];

    home.shellAliases = {
      "...." = "cd ../../..";
      "..." = "cd ../..";
      ".." = "cd ..";
      d = "docker";
      dc = "docker-compose";
      la = "ls -a";
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      rr = "rm -rf";
      ll = "ls -l";
      gs = "git status";
    };
  };
}
