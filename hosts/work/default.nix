{
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/homebrew.nix
    ../../modules/macos.nix
    ../../modules/restic-darwin.nix
  ];

  home-manager.backupFileExtension = "bkp";
  home-manager.users.gabriel = import ./home.nix;
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  environment.systemPackages = [
    pkgs.nixfmt-rfc-style
  ];

  users.users.gabriel.home = "/Users/gabriel";

  services.restic-darwin.backups = {
    icloud = {
      path = "/Users/gabriel/Library/Mobile Documents/com~apple~CloudDocs";
      repository = "b2:gabrielpoca-miscellaneous:/icloud";
      backupTime = {
        Weekday = 1; # Monday
        Hour = 10;
        Minute = 0;
      };
      pruneTime = {
        Weekday = 1; # Monday
        Hour = 22;
        Minute = 0;
      };
    };
  };

  system.primaryUser = "gabriel";
  system.stateVersion = 4;
}
