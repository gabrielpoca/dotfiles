{
  pkgs,
  self,
  nix-darwin,
  neovim-nightly-overlay,
  home-manager,
  nixpkgs,
  foundry,
  ...
}:
{
  imports = [
    ../../modules/homebrew.nix
    ../../modules/macos.nix
  ];

  nixpkgs.overlays = [
    foundry.overlay
    neovim-nightly-overlay.overlays.default
  ];

  home-manager.backupFileExtension = "bkp";
  home-manager.users.gabriel = import ./home.nix;
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment.systemPackages = [
    pkgs.nixfmt-rfc-style
  ];

  services.nix-daemon.enable = true;
  users.users.gabriel.home = "/Users/gabriel";
}
