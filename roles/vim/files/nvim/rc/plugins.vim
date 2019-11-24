call plug#begin('~/.vim/plugged')

let maplocalleader=","
Plug 'https://github.com/purpleposeidon/vim-tidal'
"Plug 'https://github.com/purpleposeidon/vim-tidal'

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
Plug 'kassio/neoterm'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'sass'] }
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" GIT
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive', { 'on': ['Gblame', 'Gstatus', 'Git'] }

" Colors
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Language Tools
Plug 'liuchengxu/vista.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'amiralies/coc-elixir', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug '~/Developer/coc-octobox', {'do': 'yarn install --frozen-lockfile'}

call plug#end()
