# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# for ctrl save on vim
stty stop '' -ixoff 

# Alias
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias ll='ls -l'
alias la='ls -a'
alias lt='ls -tr'
alias sb='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

## Git Alias
### source http://coderwall.com/filipekiss
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias g="git"
alias ga="git add"
alias gcm="git commit -m"
alias gcam="git commit -a -m"
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
alias gp="git push"

# Radio
radio() {
	if [ "$@" == "3" ]; then
		mplayer mms://rdp.oninet.pt/antena3
	elif [ "$@" == "1" ]; then
		mplayer mms://195.245.168.21/antena1
	elif [ "$@" == "uminho" ]; then
		mplayer mms://stream.radio.com.pt/ROLI-ENC-098
	elif [ "$@" == "comercial" ]; then
		mplayer http://195.23.102.196/comercialcbr96
	elif [ "$@" == "m80" ]; then
		mplayer mms://195.23.102.196/m80cbr96
	else
		echo "Radio does not exist!"
	fi
}

conflicts() { 
	vim +/"<<<<<<<" $( git diff --name-only --diff-filter=U | xargs )
}

# conf function
conf() {
	case $1 in
		bash)	vim ~/.bashrc ;;
		vim) 	vim ~/.vimrc ;;
		tmux)	vim ~/.tmux.conf;;
		zsh)	vim ~/.zshrc;;
		ssh)	vim ~/.ssh/config;;
	esac
}

# extract function
extract() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1    ;;
			*.tar.gz)    tar xvzf $1    ;;
			*.tar.xz)    tar xvJf $1    ;;
			*.bz2)       bunzip2 $1     ;;
			*.rar)       unrar x $1     ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xvf $1     ;;
			*.tbz2)      tar xvjf $1    ;;
			*.tgz)       tar xvzf $1    ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*.xz)        unxz $1        ;;
			*.exe)       cabextract $1  ;;
			*.ace)       unace $1       ;;
			*.arj)       unarj $1       ;;
			*)           echo "\`$1': unrecognized file compression" ;;
		esac
	else
		echo "\`$1' is not a valid file"
	fi
}

# cd and ls after
function chpwd() {
	emulate -L zsh
	ls
}

# mkdir with intermediate directories and cd
md() {
	mkdir -p "$1" && cd "$1";
}

# remove files with hierarchy
rr() {
	rm -rf "$@";
}

# for editing crontab in osx, this goes with something in vimrc
alias crontab="VIM_CRONTAB=true crontab"
# to disable the You have mail message from crontab
unset MAILCHECK

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="minimal"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git, rails, ruby, osx, brew, battery)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#export PATH=/usr/local/bin:/usr/local/heroku/bin:/Users/gabriel/.rvm/gems/ruby-1.9.3-p327/bin:/Users/gabriel/.rvm/gems/ruby-1.9.3-p327@global/bin:/Users/gabriel/.rvm/rubies/ruby-1.9.3-p327/bin:/Users/gabriel/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/Users/gabriel/.rvm/bin:/usr/local/sbin
export PATH=$PATH:/usr/local/bin:/usr/local/heroku/bin:/Users/gabriel/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin
