function to_sample
  youtube-dl -f bestaudio --extract-audio --quiet -o "~/Nextcloud/Projects/Music Production/Audio/1. Unprocessed - Songs to Sample/%(title)s.%(ext)s" $argv
end
