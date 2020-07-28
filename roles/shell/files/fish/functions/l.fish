# Defined in - @ line 1
function l --wraps=exa --description 'alias l=exa'
  if type -q "exa"
    exa $argv;
  else
    command ls $argv;
  end
end
