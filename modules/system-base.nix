{ pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";
  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [ pkgs.btop ];
}
