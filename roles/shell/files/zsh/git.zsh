## source http://coderwall.com/filipekiss

eval "$(hub alias -s)"
alias g="git"
alias gl="git log"
alias gc="git checkout"
alias ga="git add"
alias gd="git diff"
alias gcom="git commit -m"
alias gs="git status"
alias gb="git branch"
alias gp="git push -u"
alias gf="git fetch"
alias gu="git fetch && git rebase"

compdef _git gb="git branch"
