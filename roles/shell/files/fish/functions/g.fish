# Defined in - @ line 1
function g --wraps=git --wraps=hub --description 'alias g=hub'
  hub  $argv;
end
