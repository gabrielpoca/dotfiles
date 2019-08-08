# Navigation
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias ls="command ls ${colorflag}"

# remove files with hierarchy
rr() {
  rm -rf $@;
}
