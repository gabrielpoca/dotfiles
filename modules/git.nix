{ config, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    settings.git.pagers = [
      {
        colorArg = "always";
        pager = "delta --paging=never";
      }
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
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
    };
    ignores = [
      ".direnv/"
      ".claude/"
      ".aider*"
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
}
