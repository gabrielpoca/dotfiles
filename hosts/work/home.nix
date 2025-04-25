{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../../modules/git.nix
    ../../modules/shell.nix
    ../../modules/asdf.nix
  ];

  home.packages = with pkgs; [
    curl
    foundry-bin
    fzf
    gh
    git-crypt
    glow
    hub
    jq
    lazygit
    ncdu
    nmap
    tig
    tldr
    wget
    diff-so-fancy
    automake
    autoconf
    rustup
    nixd
    nil
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    ERL_AFLAGS = "-kernel shell_history enabled";
    FZF_DEFAULT_OPTS = "--layout=reverse";
    ZSH_CUSTOM = "$HOME/Developer/dotfiles/files/shell/zsh";
  };

  home.shellAliases.rebuild = "darwin-rebuild switch --flake $HOME/Developer/dotfiles/";

  home.sessionPath = [
    "$HOME/Developer/dotfiles/files/shell/bin"
    "/Applications/WezTerm.app/Contents/MacOS"
    "$HOME/.local/bin"
  ];

  home.file = {
    ".config/wezterm/" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/gabriel/Developer/dotfiles/files/wezterm/";
    };
    ".config/nvim/" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/gabriel/Developer/dotfiles/files/nvim";
    };
    ".hammerspoon/" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/gabriel/Developer/dotfiles/files/hammerspoon";
    };
    ".tigrc" = {
      text = ''
        bind status P !git push origin
        bind status F ?!git push -f origin
        bind status A !git commit --amend

        bind generic e @nvr -l +%(lineno) %(file)
        bind generic b @hub browse
        bind generic c @hub compare

        bind generic S :source ~/.tigrc
      '';
    };
  };

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.aria2 = {
    enable = true;
  };

  programs.fd = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.05";
}
