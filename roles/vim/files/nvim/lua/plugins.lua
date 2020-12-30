vim.cmd [[packadd packer.nvim]]
vim._update_package_paths()

return require('packer', { git = { clone_timeout = 120 } }).startup(function()
  use 'wincent/terminus'
  use 'Olical/vim-enmasse'
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
  use 'scrooloose/nerdtree'
  use 'sheerun/vim-polyglot'
  use { 'mg979/vim-visual-multi', branch = 'master' }
  use 'tpope/vim-projectionist'
  use 'tpope/vim-surround'
  use 'AndrewRadev/splitjoin.vim'
  use 'tpope/vim-abolish'
  use 'itchyny/lightline.vim'
  use '~/Developer/replacer.vim'

  --Writing
  use 'reedes/vim-pencil'
  use 'junegunn/limelight.vim'
  use 'junegunn/goyo.vim'

  --GIT
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'tpope/vim-fugitive'
  use 'stsewd/fzf-checkout.vim'

  --Colors
  use 'morhetz/gruvbox'
  use 'arcticicestudio/nord-vim'
  use 'embark-theme/vim'

  --Elixir
  use 'kana/vim-textobj-user'
  use 'andyl/vim-textobj-elixir'
  use 'mhinz/vim-mix-format' -- I'm using this because the LSP client is too slow

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
  use { 'antoinemadec/coc-fzf', run = 'yarn install --frozen-lockfile' }
  use { 'iamcco/coc-tailwindcss', run = 'yarn install --frozen-lockfile' }
end)
