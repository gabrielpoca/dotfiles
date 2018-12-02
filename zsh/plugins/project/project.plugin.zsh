function project() {
  if [ $# = 0 ]; then
    project_folder=$(pwd)
  else
    project_folder="/Users/gabrielpoca/Developer/$1"
  fi

  if [ -d $project_folder ]; then
    cd $project_folder
    sessions=`tmux list-sessions | cut -d : -f 1`
    folder=`basename $PWD`
    folder=${folder#.} # remove leading "." to have a valid tmux session name

    if [[ ! "$sessions" =~ "$folder" ]]; then
      tmux new -s $folder -d
      tmux new-window -t $folder
    fi

    if [ -n "$TMUX" ]; then
      tmux switch-client -t $folder
    else
      tmux attach -t $folder
    fi
  else
    echo "$project_folder does not exist"
  fi
}
