# Gabriel Poça's Dotfiles

My personal dotfiles managed with Nix and Home Manager.

## Prerequisites

1. Install Nix: https://nixos.org/download.html
2. Install nix-darwin: https://github.com/LnL7/nix-darwin

## Install

1. Clone the repository:

        git clone git@github.com:gabrielpoca/dotfiles.git ~/Developer/dotfiles

2. Change to the dotfiles directory:

        cd ~/Developer/dotfiles

3. Run the installation:

        darwin-rebuild switch --flake $HOME/Developer/dotfiles/

## Updating

To update your configuration after making changes:

    rebuild
