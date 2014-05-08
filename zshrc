# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Path to my configurations
CUSTOM_PATH=$HOME/.zsh

# Disable shared history
unsetopt share_history

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="awesomepanda"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(tmux, git, rails, ruby, osx, brew, battery)
plugins=(tmux, github, rails4, ruby, git)

source $ZSH/oh-my-zsh.sh

# Load custom settings
for file in $CUSTOM_PATH/*.zsh; do
  source "$file"
done

# Customize to your needs...
export PATH=$PATH:/usr/local/bin:/usr/local/heroku/bin:/Users/gabriel/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin:/Users/gabriel/.android-sdk/platform-tools:/Users/gabriel/.android-sdk/tools
