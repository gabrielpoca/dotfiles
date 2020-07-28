# Defined in - @ line 1
function ls --wraps=ex --wraps=exa --description 'alias ls=exa'
  if type -q "exa"
    exa $argv;
  else
    command ls $argv;
  end
end
