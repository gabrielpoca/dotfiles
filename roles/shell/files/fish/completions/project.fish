function __project
  ls ~/Developer
end

complete -c project -f -a '(__project)'
