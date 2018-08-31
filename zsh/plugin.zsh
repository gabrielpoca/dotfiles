dir="$(dirname "$0")"
completions="$(dirname "$0")/completions"

for file in $dir/*; do
  ! [[ $file =~ 'plugin.zsh' ]] && source $file
done

fpath=($completions $fpath)
compinit
