# Defined in - @ line 1
function la --wraps='exa -s' --wraps='exa -a' --description 'alias la=exa -a'
  exa -a $argv;
end
