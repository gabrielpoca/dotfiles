{
  description = "Personal Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    foundry.url = "github:shazow/foundry.nix/monthly";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      neovim-nightly-overlay,
      home-manager,
      nixpkgs,
      foundry,
    }:
    let
      defaultConfiguration =
        { pkgs, self, ... }:
        {
          nix.settings.experimental-features = "nix-command flakes";

          programs.zsh.enable = true;

          nixpkgs.config.allowUnfree = true;

          users.users.gabriel = {
            name = "gabriel";
          };

          system.stateVersion = 4;
        };

    in
    {
      darwinConfigurations = {
        "Gabriels-MacBook-Pro" = nix-darwin.lib.darwinSystem {
          specialArgs = inputs;

          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            defaultConfiguration
            ./hosts/work
          ];
        };
      };

      nixosConfigurations = {
        bee = nixpkgs.lib.nixosSystem {
	        specialArgs = inputs;
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/bee
         ];
        };
      };
    };
}
