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

  home.shellAliases.rebuild = "sudo nixos-rebuild switch --flake .#wasp --impure";

  home.stateVersion = "24.05";
}
