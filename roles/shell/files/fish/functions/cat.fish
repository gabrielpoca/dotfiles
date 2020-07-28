# Defined in - @ line 1
function cat --wraps=bat --description 'alias cat=bat'
  if type -q "bat"
    bat $argv;
  else
    command cat $argv
  end
end
