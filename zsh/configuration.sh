# for ctrl save on vim
stty stop '' -ixoff

# for editing crontab in osx, this goes with something in vimrc
alias crontab="VIM_CRONTAB=true crontab"

# to disable the You have mail message from crontab
unset MAILCHECK
