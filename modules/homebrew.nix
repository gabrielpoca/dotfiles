{
  config,
  lib,
  pkgs,
  ...
}:

{
  homebrew = {
    enable = true;

    casks = [
      "alt-tab"
      "blackhole-2ch"
      "docker"
      "font-hack-nerd-font"
      "hammerspoon"
      "hiddenbar"
      "hyperswitch"
      "keepassxc"
      "lulu"
      "openmtp"
      "pgadmin4"
      "postman"
      "quicklook-json"
      "raycast"
      "the-unarchiver"
      "vagrant"
      "virtualbox"
      "vlc"
      "wezterm"
    ];

    brews = [
      "asdf"
      "cormacrelf/tap/dark-notify"
      {
        name = "postgresql@16";
        restart_service = true;
        link = true;
        conflicts_with = [ "postgresql" ];
      }
      {
        name = "redis";
        restart_service = true;
        link = true;
        conflicts_with = [ "redis" ];
      }
    ];
  };
}
