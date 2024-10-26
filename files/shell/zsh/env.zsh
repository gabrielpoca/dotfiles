export HOMEBREW_NO_AUTO_UPDATE=1
# export KERL_BUILD_DOCS="yes"

if [ -n "$NVIM" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi
