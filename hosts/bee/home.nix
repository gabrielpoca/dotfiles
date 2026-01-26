{
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/git.nix
    ../../modules/shell.nix
  ];

  shell.theme = "afowler";

  home.packages = with pkgs; [
  ];

  home.shellAliases.rebuild = "sudo nixos-rebuild switch --flake .#bee --impure";

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.05";
}
