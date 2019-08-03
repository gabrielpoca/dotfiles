_color_it2prof() {
  echo -e "\033]50;SetProfile=$1\a"
}

_color_background() {
  sed -i '' "s/.*background.*/set background=$1/"  ~/.config/nvim/rc/colors.vim
}

_color_colorscheme() {
  sed -i '' "s/.*colorscheme.*/colorscheme $1/"  ~/.config/nvim/rc/colors.vim
}

_color_light() {
  _base16 "$BASE16_SHELL/scripts/base16-gruvbox-light-hard.sh"
  _color_background "light"
}

_color_dark() {
  _base16 "$BASE16_SHELL/scripts/base16-gruvbox-dark-hard.sh"
  _color_background "dark"
}

color() {
  case $1 in
    light) _color_light;;
    dark) _color_dark;;
    *) echo "the only valid arguments are 'dark' and 'light'" ;;
  esac
}
