{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.shell.theme;
in
{
  options.shell.theme = mkOption {
    type = types.str;
    default = "robbyrussell";
  };

  config = {
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
          "asdf"
          "aws"
          "fzf"
          "gh"
          "mix"
          "npm"
        ];
        theme = cfg;
      };
    };

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
