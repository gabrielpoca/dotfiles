set -gx PATH $PATH /Users/gabrielpoca/Developer/dotfiles/roles/shell/files/bin
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git --ignore "*.png" --ignore "*.jpg" -g ""'

if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
end

if test -e ~/.config/fish/local.fish
  source ~/.config/fish/local.fish
end

eval (direnv hook fish)