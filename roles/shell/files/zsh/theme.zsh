export COLORSCHEME='catppuccin'

current=$(defaults read -g AppleInterfaceStyle 2> /dev/null)

if [[ $current == 'Dark' ]]; then
  export COLORSCHEME_VARIANT='mocha'
else
  export COLORSCHEME_VARIANT='latte'
fi

# export FZF_PREVIEW_PREVIEW_BAT_THEME=gruvbox

if [[ $COLORSCHEME == "catppuccin" ]]; then
  if [[ $COLORSCHEME_VARIANT == "mocha" ]]; then
    export FZF_DEFAULT_OPTS="--layout=reverse \
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
  elif [[ $COLORSCHEME_VARIANT == "latte" ]]; then
    export FZF_DEFAULT_OPTS="--layout reverse \
      --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
      --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
      --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
  else
    echo "Invalid COLORSCHEME_VARIANT" 1>&2
  fi
fi

# update alacritty config
sed -i '' -e "s/^colors: .*$/colors: *$COLORSCHEME\_$COLORSCHEME_VARIANT/" "$DOTFILES/roles/shell/files/alacritty/alacritty.yml"
