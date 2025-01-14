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
}
