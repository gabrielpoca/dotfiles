export COLORSCHEME='catppuccin'
export COLORSCHEME_VARIANT='mocha'
export COLORSCHEME_VARIANT='mocha'

export FZF_PREVIEW_PREVIEW_BAT_THEME=gruvbox

if [[ $COLORSCHEME == "catppuccin" ]]; then
  if [[ $COLORSCHEME_VARIANT == "mocha" ]]; then
    export FZF_DEFAULT_OPTS=" \
      --layout=reverse
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
  fi
fi

# update alacritty config
sed -i -e "s/^colors: .*$/colors: *$COLORSCHEME\_$COLORSCHEME_VARIANT/" "$DOTFILES/roles/shell/files/alacritty/alacritty.yml"
