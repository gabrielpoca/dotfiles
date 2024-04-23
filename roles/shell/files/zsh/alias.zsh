alias ....="cd ...."
alias ...="cd ..."
alias ..="cd .."
alias cat="bat --theme=gruvbox"
alias d=docker
alias dc="docker-compose"
alias g=git
alias gd="git diff"
alias gs="git status"
alias la="ls -a"
alias preview=glow
alias v=nvim
alias vi=nvim
alias vim=nvim
alias rr="rm -rf"
alias t=terraform
alias tl="tmux list-sessions"
alias ta="tmux attach-session -t"
alias tk="tmux kill-server"

if [ -n "$NVIM" ]; then
    alias nvim="nvr -cc split --remote-wait +'set bufhidden=wipe'"
fi
