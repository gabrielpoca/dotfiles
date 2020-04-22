function project --argument-names 'project'
  if test -n "$project"
    set project_folder "/Users/gabrielpoca/Developer/$project"
  else
    set project_folder (pwd)
  end

  if test -d $project_folder
    cd $project_folder
    set sessions (tmux list-sessions | cut -d : -f 1)
    set folder (basename $PWD)
    set folder (string replace -a '.' _ $folder)

    if not contains $sessions $folder
      tmux new -s $folder -d -n "vim"
      tmux new-window -d -c $project_folder -n "shell" -t $folder
    end

    if test -n "$TMUX"
      tmux switch-client -t $folder
    else
      tmux attach -t $folder
    end
  else
    echo "$project_folder does not exist"
  end
end
