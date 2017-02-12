#!/usr/bin/env ruby

require 'fileutils'

FILES = [
  ['.gitconfig', 'gitconfig'],
  ['.gitignore', 'gitignore'],
  ['.gitmessage', 'gitmessage'],
  ['.rspec', 'rspec'],
  ['.tmux.conf', 'tmux.conf'],
  ['.zshrc.local', 'zshrc.local'],
  ['.kwm/kwmrc', 'kwmrc'],
  ['.zazurc.json', 'zazurc.json'],
  ['.config/nvim/init.vim', 'nvimrc'],
  ['.khdrc', 'khdrc']
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

unless File.exist?(File.join(Dir.home, '.local/share/nvim/site/autoload/plug.vim'))
  puts 'Installing plug.vim'
  system 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
end

unless File.directory?(File.join(Dir.home, '.antigen'))
  puts 'Installing antigen'
  system 'git clone git@github.com:zsh-users/antigen.git ~/.antigen'
end

unless File.file?(File.join(Dir.home, '.zshrc'))
  puts 'Installin zshrc'
  FileUtils.cp 'zshrc', File.join(Dir.home, '.zshrc')
end

unless system('type "brew" > /dev/null')
  puts 'Installing homebrew'
  system 'curl -fsSL \
    https://raw.githubusercontent.com/Homebrew/install/master/install)'
end

puts "Complete! Don't forget to update .zshrc"
