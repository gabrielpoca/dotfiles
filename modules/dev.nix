{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    automake
    autoconf
    curl
    diff-so-fancy
    gh
    git-crypt
    glow
    hub
    jq
    ncdu
    nil
    nixd
    neovim
    nmap
    rustup
    tig
    tldr
    tmux
    transcrypt
    wget
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    ERL_AFLAGS = "-kernel shell_history enabled";
  };

  home.file.".tigrc".text = ''
    bind status P !git push origin
    bind status F ?!git push -f origin
    bind status A !git commit --amend

    bind generic e @nvr -l +%(lineno) %(file)
    bind generic b @hub browse
    bind generic c @hub compare

    bind generic S :source ~/.tigrc
  '';

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.ripgrep.enable = true;

  programs.aria2.enable = true;

  programs.fd.enable = true;
}
