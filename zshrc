# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Load nvm
export NVM_DIR="/Users/gabriel/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

unsetopt share_history

ZSH_THEME="avit"
COMPLETION_WAITING_DOTS="true"

plugins=(git rails grunt ruby zsh-syntax-highlighting tmux cp my-git my-dir my-apps my-config)

source $ZSH/oh-my-zsh.sh

# Customize to your needs.
export PATH=/usr/local/bin:$PATH:/usr/local/heroku/bin:/Users/gabriel/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin:$HOME/.bin:$HOME/.android-sdk/platform-tools:$HOME/.android-sdk/tools

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
