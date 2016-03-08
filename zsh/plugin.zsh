folder="$(dirname "$0")"

for file in $folder/*; do
  ! [[ $file =~ 'plugin.zsh' ]] && source $file
done
