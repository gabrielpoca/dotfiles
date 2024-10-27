{
  neovim-nightly-overlay,
  pkgs,
  config,
  foundry,
  pkgs-unstable,
  imports,
  ...
}:
{
  imports = [
    ./modules/git.nix
    ./modules/zsh.nix
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
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    ERL_AFLAGS = "-kernel shell_history enabled";
    FZF_DEFAULT_OPTS = "--layout=reverse";
    ZSH_CUSTOM = "$HOME/Developer/dotfiles/files/shell/zsh";
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
    rebuild = "darwin-rebuild switch --flake $HOME/Developer/dotfiles/";
    ll = "ls -l";
  };

  home.sessionPath = [
    "$HOME/Developer/dotfiles/files/shell/bin"
    "/Applications/WezTerm.app/Contents/MacOS"
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
    ".default-gems" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/gabriel/Developer/dotfiles/files/asdf/default-gems";
    };
    ".default-npm-packages" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/gabriel/Developer/dotfiles/files/asdf/default-npm-packages";
    };
    ".default-python-packages" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/gabriel/Developer/dotfiles/files/asdf/default-python-packages";
    };
    ".tool-versions" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/gabriel/Developer/dotfiles/files/asdf/tool-versions";
    };
    ".tigrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/gabriel/Developer/dotfiles/files/shell/tigrc";
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

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
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
