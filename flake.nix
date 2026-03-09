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
      samba         = import ./modules/stacks/samba.nix;
      server        = import ./modules/stacks/server.nix;
    };
  };
}
