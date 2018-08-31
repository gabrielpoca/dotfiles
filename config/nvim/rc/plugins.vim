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
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

" Colors
Plug 'scwood/vim-hybrid'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'

" Languages
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'sass'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'sass'] }

" Autocomplete
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Ruby
Plug 'tpope/vim-rails', { 'for': 'ruby' }

call plug#end()
