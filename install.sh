#!/bin/sh

current_dir=$(pwd)

files="gitconfig.local gitmessage gitignore.local rspec tmux.conf zshrc.local"

for file in $files; do
  echo "installing $file"
  if [ ! -e ~/.$file ]; then
    ln -s $current_dir/$file ~/.$file
  fi
done

echo "installing nvimrc"
mkdir -p ~/.config/nvim
ln -s $current_dir/nvimrc ~/.config/nvim/init.vim

echo "installing vim-plug"
curl -fLo ~/.nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "installing zshrc"
git clone git@github.com:zsh-users/antigen.git ~/.antigen-repo
if [ ! -f ~/.zshrc ]; then
  cp zshrc ~/.zshrc
fi

echo "installing init.el"
mkdir -p ~/.emacs.d
if [ ! -f ~/.emacs.d/init.el ]; then
  cp init.el ~/.emacs.d/init.el
  touch ~/.emacs.d/custom.el
fi

echo "complete, don't forget to update the .zshrc"
