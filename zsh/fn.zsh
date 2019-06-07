# Play an alarm file once your internet connection returns.
wait_for_net() {
  until ping -W1 -c1 8.8.8.8; do sleep 5; done && radio 3
}

# Waiting for the CI and ouput the result
wait_for_ci() {
  while [ "$(git ci-status)" == "pending" ]; do sleep 4; done; echo "CI finished with status $(git ci-status)"
}

# listen to radio
radio() {
  if [ "$@" == "3" ]; then
    mplayer mms://rdp.oninet.pt/antena3
  elif [ "$@" == "1" ]; then
    mplayer mms://195.245.168.21/antena1
  else
    echo "Radio \"$1\" not recognized"
  fi
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

crypt-folder() {
  tar -cz $1 | gpg -c -o ${1}.tgz.gpg
}

decrypt-folder() {
  gpg -d ${1} | tar xz
}

list_colors() {
  for i in {0..255} ; do printf "\x1b[38;5;${i}mcolour${i}\n"; done;
}

function f() { "$@" | fzf }

fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

mp3 () {
	youtube-dl --ignore-errors -f bestaudio --extract-audio --audio-format wav --no-playlist --audio-quality 0 -o '~/Music/Ableton/User Library/Personal/Youtube to Sample/%(title)s.%(ext)s' "$1"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
