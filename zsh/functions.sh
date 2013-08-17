# run ls on file change. The -G flag is for colors.
function chpwd() {
  emulate -L zsh
  ls -G
}

# remove files with hierarchy
rr() {
  rm -rf "$@";
}
