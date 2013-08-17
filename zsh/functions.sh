# run ls on file change. The -G flag is for colors.
function chpwd() {
  emulate -L zsh
  ls -G
}

# mkdir with intermediate directories and cd
md() {
  mkdir -p "$1" && cd "$1";
}

# remove files with hierarchy
rr() {
  rm -rf "$@";
}
