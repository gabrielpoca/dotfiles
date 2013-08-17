# Git
## source http://coderwall.com/filipekiss
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias g="git"
alias gc="git checkout"
alias ga="git add"
alias gco="git commit -m"
alias gcom="git commit -a -m"
alias gs="git status"
alias gb="git branch"
alias gp="git push"
alias gf="git fetch"

# Navigation
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'


# Detect which `ls` flavor is in use
# if ls --color > /dev/null 2>&1; then # GNU `ls`
    # colorflag="--color"
# else # OS X `ls`
    colorflag="-G"
# fi

alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias lsd='ls -l ${colorflag} | grep "^d"'
alias ls="command ls ${colorflag}"
