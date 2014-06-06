# Play an alarm file once your internet connection returns.
wait_for_net() {
  until ping -W1 -c1 8.8.8.8; do sleep 5; done && afplay ~/alarm.mp3
}

# quick go to configuration
conf() {
  case $1 in
    bash) vim ~/.bashrc ;;
    vim)  vim ~/.vimrc ;;
    tmux) vim ~/.tmux.conf;;
    zsh)  vim ~/.zshrc;;
    ssh)  vim ~/.ssh/config;;
  esac
}

crypt-folder() {
  tar -cz $1 | gpg -c -o ${1}.tgz.gpg
}

decrypt-folder() {
  gpg -d ${1} | tar xz
}

# extract all kind of files
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

# open conflicted files
conflicts() {
  vim +/"<<<<<<<" $( git diff --name-only --diff-filter=U | xargs )
}

# check latex file
alias check="aspell --lang=pt_pt --mode=tex check"

# listen to radio
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

f-new() {
  new_branch="$1"
  source_branch=${2:-master}
  git checkout $source_branch && git fetch && git rebase && git branch $new_branch && git checkout $new_branch
}

f-merge() {
  branch=`git branch | sed -n '\/* /s///p'`
  destiny_branch=${1:-master}
  git fetch && git checkout $destiny_branch && git rebase && git checkout $branch &&  git rebase $destiny_branch && git rebase -i $destiny_branch && git push -f && git checkout $destiny_branch && git merge $branch && git push && git push origin :$branch && git branch -d $branch
}
