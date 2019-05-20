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
  _color_it2prof "Light"
  _color_background "light"
  _color_colorscheme "onehalflight"
}

_color_dark() {
  _color_it2prof "Dark"
  _color_background "dark"
  _color_colorscheme "nord"
}

color() {
  case $1 in
    light) _color_light;;
    dark) _color_dark;;
    *) echo "unrecognized colorscheme $1" ;;
  esac
}

if [ ! -n "$TMUX" ]; then
	_color_dark
fi
