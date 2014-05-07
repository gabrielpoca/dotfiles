# Git
## source http://coderwall.com/filipekiss
alias g="git"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias gc="git checkout"
alias ga="git add"
alias gd="git diff"
alias gcom="git commit -m"
alias gs="git status"
alias gb="git branch"
alias gp="git push"
alias gf="git fetch"

# Navigation
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'


# Application
alias s='spring'
alias scu='spring cucumber'
alias srs='spring rspec spec'
alias sc='spring rails c'
alias ss='spring rails s'
alias sr='spring rake'

#alias vim="reattach-to-user-namespace vim"
#alias mvim="reattach-to-user-namespace /usr/local/Cellar/macvim/7.4-7/MacVim.app/Contents/MacOS/Vim"
#alias vim="reattach-to-user-namespace /usr/local/Cellar/macvim/7.4-72/MacVim.app/Contents/MacOS/Vim"
#alias vi="reattach-to-user-namespace /usr/local/Cellar/macvim/7.4-72/MacVim.app/Contents/MacOS/Vim"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias lsd='ls -l ${colorflag} | grep "^d"'
alias ls="command ls ${colorflag}"
