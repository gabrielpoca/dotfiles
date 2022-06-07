vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

require('packer', { git = { clone_timeout = 120 } }).startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  use 'wincent/terminus'
  use 'christoomey/vim-tmux-navigator'
  use 'derekprior/vim-trimmer'
  use 'embear/vim-localvimrc'
  use 'farmergreg/vim-lastplace'
  use 'gcmt/wildfire.vim'
  use 'vim-test/vim-test'
  use 'numToStr/Comment.nvim'
  use { 'mg979/vim-visual-multi', branch = 'master' }
  use 'tpope/vim-projectionist'
  use 'tpope/vim-surround'
  use 'AndrewRadev/splitjoin.vim'
  use 'tpope/vim-abolish'
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use '~/Developer/replacer.nvim'
  use { 'kristijanhusak/any-jump.vim', commit = '471094ddacbe65d68439e95af9ee01e120a867ec' }
  use 'ryanoasis/vim-devicons'
  use 'voldikss/vim-floaterm'
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use 'thesis/vim-solidity'
  use 'folke/which-key.nvim'
  use 'phaazon/hop.nvim'
  use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
  use 'antoinemadec/FixCursorHold.nvim'
  use 'sheerun/vim-polyglot'
  use { 'evanleck/vim-svelte', requires = { 'pangloss/vim-javascript', 'othree/html5.vim' } }
  use { 'mrjones2014/legendary.nvim', requires = { 'nvim-telescope/telescope.nvim', 'stevearc/dressing.nvim' } }

  --GIT
  use 'tpope/vim-fugitive'

  --Colors
  --use 'morhetz/gruvbox'
  use 'dracula/vim'

  -- CSS
  use { 'jasonlong/vim-textobj-css', requires = 'kana/vim-textobj-user' }
    use {"catppuccin/nvim", as = "catppuccin"}

  --Ruby
  use 'tpope/vim-rails'

  --Elixir
  use 'elixir-editors/vim-elixir'
  use 'slime-lang/vim-slime-syntax'
  use { 'andyl/vim-textobj-elixir', requires = 'kana/vim-textobj-user' }

  -- Lua
  use { 'tjdevries/nlua.nvim' }

  -- Fuzzy finder
  use { 'junegunn/fzf', dir = '~/.fzf', config = './install --all' }
  use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  }

  -- Completion
  use { 'github/copilot.vim' }
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use { 'ms-jpq/coq.thirdparty' }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }
end)
