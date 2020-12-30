call plug#begin('~/.vim/plugged')

Plug 'wincent/terminus'
Plug 'Olical/vim-enmasse'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekprior/vim-trimmer'
Plug 'easymotion/vim-easymotion'
Plug 'embear/vim-localvimrc'
Plug 'farmergreg/vim-lastplace'
Plug 'gcmt/wildfire.vim'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-abolish'
Plug 'itchyny/lightline.vim'
Plug 'gabrielpoca/replacer.nvim', { 'dir': '~/Developer/replacer.vim' }

" Writing
Plug 'reedes/vim-pencil'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

" GIT
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'stsewd/fzf-checkout.vim'

" Colors
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'embark-theme/vim'

" Elixir
Plug 'kana/vim-textobj-user'
Plug 'andyl/vim-textobj-elixir'
Plug 'mhinz/vim-mix-format' " I'm using this because the LSP client is too slow

" Language Tools
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'amiralies/coc-elixir', {'do': 'yarn install --frozen-lockfile && yarn prepack'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'antoinemadec/coc-fzf', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-tailwindcss', {'do': 'yarn install --frozen-lockfile'}

call plug#end()
