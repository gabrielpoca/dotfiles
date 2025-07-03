{
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/homebrew.nix
    ../../modules/macos.nix
  ];

  home-manager.backupFileExtension = "bkp";
  home-manager.users.gabriel = import ./home.nix;
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment.systemPackages = [
    pkgs.nixfmt-rfc-style
  ];

  users.users.gabriel.home = "/Users/gabriel";

  system.primaryUser = "gabriel";
  system.stateVersion = 4;
}
