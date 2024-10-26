{
  neovim-nightly-overlay,
  pkgs,
  config,
  foundry,
  pkgs-unstable,
  ...
}:
{
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
  };

  home.shellAliases = {
    "...." = "cd ../../..";
    "..." = "cd ../..";
    ".." = "cd ..";
    d = "docker";
    dc = "docker-compose";
    g = "git";
    gd = "git diff";
    gs = "git status";
    la = "ls -a";
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    rr = "rm -rf";
    rebuild = "darwin-rebuild switch --flake $HOME/Developer/dotfiles/";
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

  programs.zsh = {
    enable = true;

    history = {
      size = 10000;
    };
    sessionVariables = {
      ZSH_CUSTOM = "$HOME/Developer/dotfiles/files/shell/zsh";
    };
    shellAliases = {
      ll = "ls -l";
      update = "home-manager switch";
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

  programs.git = {
    enable = true;
    userName = "Gabriel Poca";
    userEmail = "mail@gabrielpoca.com";
    delta.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
      color = {
        ui = true;
      };
      github = {
        user = "gabrielpoca";
      };
    };
    ignores = [
      "!tmp/cache/.keep"
      "$TMPDIR/"
      "*.DS_Store"
      "*.sublime-project"
      "*.sublime-workspace"
      "*.sw[nop]"
      ".DS_Store"
      ".bundle"
      ".dir-locals.el"
      ".elixir_ls/"
      ".env"
      ".envrc"
      ".history/"
      ".lvimrc"
      ".projections.json"
      ".tern-port"
      ".tern-project"
      ".textlintrc"
      ".vagrant/"
      ".vimrc"
      ".vscode/"
      ".wercker/"
      "MY_NOTES.md"
      "db/*.sqlite3"
      "dump"
      "dump.rdb"
      "dump.sql"
      "log/*.log"
      "node_modules"
      "provision.retry"
      "tags"
      "tags.*"
      "tmp/**/*"
      ".terraform/"
      ".env.dev.local"
      "config/credentials/*"
      "deployments/*"
      "typechain-types"
      "*.code-workspace"
      ".luarc.json"
      ".pnp.*"
    ];
    attributes = [
      "db/schema.rb merge=railsschema"
      "*.js text eol=lf"
      "*.jsx text eol=lf"
      "*.ts text eol=lf"
      "*.tsx text eol=lf"
      "package.json text eol=lf"
    ];
    aliases = {
      a = "add";
      b = "branch";
      c = "checkout";
      cb = "checkout -b";
      co = "commit";
      d = "diff";
      f = "fetch";
      p = "push -u";
      r = "rebase";
      rc = "rebase --continue";
      s = "status";
    };
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
