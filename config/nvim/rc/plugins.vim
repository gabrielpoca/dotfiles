call plug#begin('~/.vim/plugged')

Plug 'wincent/terminus'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Olical/vim-enmasse'
Plug 'SirVer/ultisnips'
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

" GIT
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive', { 'on': ['Gblame', 'Gstatus', 'Git'] }

" Colors
Plug 'morhetz/gruvbox'

" Languages
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'sass'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'sass'] }

" Language Tool
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'amiralies/coc-elixir', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-svg', {'do': 'yarn install --frozen-lockfile'}

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx', 'typescript'] }

" Ruby
Plug 'tpope/vim-rails', { 'for': 'ruby' }

call plug#end()
