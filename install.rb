#!/usr/bin/env ruby

require 'fileutils'

FILES = [
  ['.gitconfig', 'gitconfig'],
  ['.gitattributes', 'gitattributes'],
  ['.gitignore', 'gitignore'],
  ['.gitcommit', 'gitcommit'],
  ['.rspec', 'rspec'],
  ['.tmux.conf', 'tmux.conf'],
  ['.zshrc.local', 'zshrc.local'],
].freeze

FOLDERS = [
  ['.config/nvim', 'config/nvim'],
  ['.config/alacritty', 'config/alacritty'],
].freeze

FILES.each do |dest_file, file|
  dest_file = File.join(Dir.home, dest_file)
  dest_folder = File.dirname(dest_file)
  source_file = File.join(Dir.pwd, file)

  next if File.symlink?(dest_file)

  puts "Installing #{file}"
  FileUtils.mkdir_p dest_folder
  FileUtils.ln_s source_file, dest_file
end

FOLDERS.each do |dest_folder, folder|
  next if File.exist?(File.join(Dir.home, dest_folder))

  puts "Installing #{File.basename(folder)}"

  FileUtils.ln_s File.join(Dir.pwd, folder), File.join(Dir.home, dest_folder)
end

unless File.directory?(File.join(Dir.home, '.antigen'))
  puts 'Installing antigen'
  system 'git clone git@github.com:zsh-users/antigen.git ~/.antigen'
end

unless File.file?(File.join(Dir.home, '.zshrc'))
  puts 'Installin zshrc'
  FileUtils.cp 'zshrc', File.join(Dir.home, '.zshrc')
end

unless File.file?(File.join(Dir.home, '.netrc'))
  puts 'Installing .netrc'
  FileUtils.cp 'netrc', File.join(Dir.home, '.netrc')
  puts 'Do not forget to update .netrc'
end

unless system('type "brew" > /dev/null')
  puts 'Installing homebrew'
  system 'curl -fsSL \
    https://raw.githubusercontent.com/Homebrew/install/master/install)'
end

unless system('which diff-so-fancy > /dev/null')
  puts 'Installing diff-so-fancy'

  system('brew install diff-so-fancy')
end

unless system('which reattach-to-user-namespace > /dev/null')
  puts 'Installing reattach-to-user-namespace'

  system('brew install reattach-to-user-namespace')
end

terminfo = File.join(Dir.home, '.terminfo')
unless File.directory?(terminfo)
  FileUtils.mkdir_p terminfo
  puts 'Installing terminfo'
  system "tic -o #{terminfo} tmux.terminfo"
  system "tic -o #{terminfo} tmux-256color.terminfo"
  system "tic -o #{terminfo} xterm-256color.terminfo"
end

puts "Complete! Don't forget to update .zshrc"
