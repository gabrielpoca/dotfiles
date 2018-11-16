setopt HIST_IGNORE_SPACE
export TERM=screen-256color

# check latex file
alias check="aspell --lang=pt_pt --mode=tex check"

# for editing crontab in osx, this goes with something in vimrc
alias crontab="VIM_CRONTAB=true crontab"

# to disable the You have mail message from crontab
unset MAILCHECK

# lang
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export EDITOR=nvim

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore "*.png" --ignore "*.jpg" -g ""'
