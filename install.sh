#!/bin/sh

current_dir=$(pwd)

files="gitconfig.local gitmessage gitignore.local nvimrc rspec tmux.conf zshrc.local"

echo "installing dotfiles"
for file in $files; do
  if [ ! -e ~/.$file ]; then
    ln -s $current_dir/$file ~/.$file
  fi
done

echo "installing vim-plug"
curl -fLo ~/.nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "installing zshrc"
if [ ! -f ~/.zshrc ]; then
  file="
source ~/dotfiles/antigen/antigen.zsh\n
source ~/.zshrc.local"
  echo $file > ~/.zshrc
fi

echo "complete, don't forget to update the .zshrc"
