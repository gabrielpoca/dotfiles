export HOMEBREW_NO_AUTO_UPDATE=1
export MIX_OS_DEPS_COMPILE_PARTITION_COUNT=6

if [ -n "$NVIM" ]; then
  export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
  export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
fi
