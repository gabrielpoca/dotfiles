# Defined in - @ line 1
function rr --wraps='rm -rf' --description 'alias rr=rm -rf'
  rm -rf $argv;
end
