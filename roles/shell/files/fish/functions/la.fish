# Defined in - @ line 1
function la --wraps='exa -s' --wraps='exa -a' --description 'alias la=exa -a'
  if type -q "exa"
    exa -a $argv;
  else
    command ls -a $argv;
  end
end
