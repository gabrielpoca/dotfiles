# Defined in - @ line 1
function ls --wraps=ex --wraps=exa --description 'alias ls=exa'
  exa  $argv;
end
