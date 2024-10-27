{ config, pkgs, ... }:

{
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
      theme = "robbyrussell";
    };
    initExtra = ''
      . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
      . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
    '';
  };
}
