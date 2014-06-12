function conf
  switch $argv
    case vim
      vim ~/.vimrc
    case tmux
      vim ~/.tmux.conf
    case fish
      vim ~/.conf/config.fish
    case '*'
      echo 'Unknown argument'
  end
end
