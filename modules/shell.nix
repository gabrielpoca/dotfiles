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
