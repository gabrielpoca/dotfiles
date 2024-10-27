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
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      neovim-nightly-overlay,
      home-manager,
      nixpkgs,
      foundry,
      rust-overlay,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          services.nix-daemon.enable = true;

          nix.settings.experimental-features = "nix-command flakes";

          programs.zsh.enable = true; # default shell on catalina

          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 4;

          nixpkgs.hostPlatform = "aarch64-darwin";
          nixpkgs.overlays = [
            foundry.overlay
            rust-overlay.overlays.default
            neovim-nightly-overlay.overlays.default
          ];

          # allowUnfree is required to install some packages that are not "free" software.
          nixpkgs.config.allowUnfree = true;

          users.users.gabriel = {
            name = "gabriel";
            home = "/Users/gabriel";
          };

          environment.systemPackages = [
            pkgs.vim
            pkgs.rust-bin.stable.latest.default
            pkgs.nixfmt-rfc-style
          ];

          home-manager.backupFileExtension = "bkp";
          home-manager.users.gabriel = import ./home.nix;
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
        };

    in
    {
      darwinConfigurations."Gabriels-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          configuration
          ./modules/homebrew.nix
          ./modules/macos.nix
        ];
      };

      darwinPackages = self.darwinConfigurations."Gabriels-MacBook-Pro".pkgs;
    };
}
