set -gx PATH $PATH /Users/gabriel/Developer/dotfiles/roles/shell/files/bin
set -gx PATH $PATH /Users/gabriel/.elixir-ls
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git --ignore "*.png" --ignore "*.jpg" -g ""'
set -gx FZF_DEFAULT_OPTS '--color gutter:0,bg+:232,fg+:219 --layout=reverse --history=/Users/gabriel/.fzf_history'
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set fish_greeting

if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
end

if test -e ~/.config/fish/local.fish
  source ~/.config/fish/local.fish
end

eval (direnv hook fish)
