# shortcuts
alias sb='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'

# functions
alias lolbug="ps aux | grep UserKernel | grep -v grep | egrep -o \"^[a-z]+[ ]+[0-9]+\" | egrep -o \"[0-9]+\" | xargs kill -9"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
