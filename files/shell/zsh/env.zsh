export HOMEBREW_NO_AUTO_UPDATE=1

if [ -n "$NVIM" ]; then
  export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
  export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
fi
