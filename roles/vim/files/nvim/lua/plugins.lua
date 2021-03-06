vim.cmd [[packadd packer.nvim]]

return require('packer', { git = { clone_timeout = 120 } }).startup(function()
  use { 'wbthomason/packer.nvim', opt = true }
  use 'wincent/terminus'
  use 'christoomey/vim-tmux-navigator'
  use 'derekprior/vim-trimmer'
  use 'easymotion/vim-easymotion'
  use 'embear/vim-localvimrc'
  use 'farmergreg/vim-lastplace'
  use 'gcmt/wildfire.vim'
  use 'janko-m/vim-test'
  use { 'junegunn/fzf', dir = '~/.fzf', config = './install --all' }
  use 'junegunn/fzf.vim'
  use 'scrooloose/nerdcommenter'
  use { 'mg979/vim-visual-multi', branch = 'master' }
  use 'tpope/vim-projectionist'
  use 'tpope/vim-surround'
  use 'AndrewRadev/splitjoin.vim'
  use 'tpope/vim-abolish'
  use 'itchyny/lightline.vim'
  use '~/Developer/replacer.nvim'
  use { 'kristijanhusak/any-jump.vim', commit = '471094ddacbe65d68439e95af9ee01e120a867ec' }
  use 'ryanoasis/vim-devicons'
  use 'voldikss/vim-floaterm'

  --Writing
  use 'reedes/vim-pencil'
  use 'junegunn/goyo.vim'
  use 'rhysd/vim-grammarous'

  --GIT
  use 'tpope/vim-fugitive'

  --Colors
  use 'morhetz/gruvbox'
  use {'nvim-treesitter/nvim-treesitter', config = ':TSUpdate'}

  --Ruby
  use 'tpope/vim-rails'

  --Elixir
  use 'elixir-editors/vim-elixir'
  use 'kana/vim-textobj-user'
  use 'andyl/vim-textobj-elixir'

  --Language Tools
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'neoclide/coc-highlight', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-json', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-prettier', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-snippets', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-tsserver', run = 'yarn install --frozen-lockfile' }
  use { 'neoclide/coc-css', run = 'yarn install --frozen-lockfile' }
  use { 'amiralies/coc-elixir', run = 'yarn install --frozen-lockfile && yarn prepack' }
  use { 'neoclide/coc-git', run = 'yarn install --frozen-lockfile' }
  use { 'weirongxu/coc-explorer', run = 'yarn install --frozen-lockfile' }
  use { 'fannheyward/coc-rust-analyzer', run = 'yarn install --frozen-lockfile' }
  use { 'josa42/coc-lua', run = 'yarn install --frozen-lockfile' }
end)
