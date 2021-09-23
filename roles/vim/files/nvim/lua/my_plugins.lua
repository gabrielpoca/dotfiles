vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

require('packer', { git = { clone_timeout = 120 } }).startup(function()
  use { 'wbthomason/packer.nvim', opt = true }
  use 'wincent/terminus'
  use 'christoomey/vim-tmux-navigator'
  use 'derekprior/vim-trimmer'
  use 'easymotion/vim-easymotion'
  use 'embear/vim-localvimrc'
  use 'farmergreg/vim-lastplace'
  use 'gcmt/wildfire.vim'
  use 'janko-m/vim-test'
  use 'scrooloose/nerdcommenter'
  use {
    'mg979/vim-visual-multi',
    branch = 'master',
  }
  use 'tpope/vim-projectionist'
  use 'tpope/vim-surround'
  use 'AndrewRadev/splitjoin.vim'
  use 'tpope/vim-abolish'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }
  use '~/Developer/replacer.nvim'
  use {
    'kristijanhusak/any-jump.vim',
    commit = '471094ddacbe65d68439e95af9ee01e120a867ec',
  }
  use 'ryanoasis/vim-devicons'
  use 'voldikss/vim-floaterm'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  --GIT
  use 'tpope/vim-fugitive'

  --Colors
  --use 'morhetz/gruvbox'
  use 'dracula/vim'
  use {'nvim-treesitter/nvim-treesitter', config = ':TSUpdate'}

  --Ruby
  use 'tpope/vim-rails'

  --Elixir
  use 'elixir-editors/vim-elixir'
  use 'kana/vim-textobj-user'
  use 'andyl/vim-textobj-elixir'
  use 'slime-lang/vim-slime-syntax'

  -- Lua
  use { 'tjdevries/nlua.nvim' }

  -- Fuzzy finder
  use {
    'junegunn/fzf',
    dir = '~/.fzf',
    config = './install --all',
  }
  use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }}
  }

  -- Completion
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

  -- LSP
  use { 'neovim/nvim-lspconfig' }
  --use { 'nvim-lua/completion-nvim' }
  --use { 'aca/completion-tabnine', { config = 'version=3.1.9 ./install.sh' } }
  --use { 'steelsojka/completion-buffers' }

  -- Writing
  use { 'reedes/vim-pencil' }
  use { "Pocco81/TrueZen.nvim" }
end)
