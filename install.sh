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
if [ ! -f ~/.config/nvim/init.vim ]; then
  ln -s $current_dir/nvimrc ~/.config/nvim/init.vim
fi

echo "installing vim-plug"
if [ ! -f ~/.nvim/autoload/plug.vim ]; then
  curl -fLo ~/.nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "installing zshrc"
if [ ! -d ~/.antigen-repo ]; then
  git clone git@github.com:zsh-users/antigen.git ~/.antigen-repo
fi

if [ ! -f ~/.zshrc ]; then
  cp zshrc ~/.zshrc
fi

echo "installing init.el"
mkdir -p ~/.emacs.d
if [ ! -f ~/.emacs.d/init.el ]; then
  cp init.el ~/.emacs.d/init.el
  touch ~/.emacs.d/custom.el
fi

echo "installing kwm"
mkdir -p ~/.kwm
if [ ! -f ~/.kwm/kwmrc ]; then
  ln -s $current_dir/kwmrc ~/.kwm/kwmrc
fi
if [ ! -f ~/.khdrc ]; then
  ln -s $current_dir/khdrc ~/.khdrc
fi

echo "complete, don't forget to update the .zshrc"
