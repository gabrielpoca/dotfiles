function boot --argument-names 'boot'
  set sessions (tmux list-sessions | cut -d : -f 1)

  if not contains $sessions "boot"
    tmux new -c ~/Developer -d -s "boot"
  end

  if test -n "$TMUX"
    tmux switch-client -t "boot"
  else
    tmux attach -t "boot"
  end
end
