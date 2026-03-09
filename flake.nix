{
  description = "Public Nix modules";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, ... }: {
    modules = {
      shell         = import ./modules/shell.nix;
      git           = import ./modules/git.nix;
      languages     = import ./modules/languages.nix;
      homebrew      = import ./modules/homebrew.nix;
      macos         = import ./modules/macos.nix;
      restic-darwin = import ./modules/restic-darwin.nix;
      server        = import ./modules/server.nix;
      dev           = import ./modules/dev.nix;
    };
  };
}
