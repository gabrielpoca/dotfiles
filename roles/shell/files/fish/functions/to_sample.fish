function to_sample
  youtube-dl -f bestaudio --extract-audio --quiet -o "~/Nextcloud/Projects/Audio/Songs to Sample/%(title)s.%(ext)s" $argv
end
