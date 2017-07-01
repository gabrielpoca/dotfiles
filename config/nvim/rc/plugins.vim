call plug#begin('~/.vim/plugged')

" => Writing
Plug 'vimwiki/vimwiki'
Plug 'rhysd/vim-grammarous'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'reedes/vim-pencil'
Plug 'vim-voom/VOoM'

Plug 'tpope/vim-rhubarb' " use with vim-fugitive
Plug 'tpope/vim-fugitive'

Plug 'farmergreg/vim-lastplace'
Plug 'Olical/vim-enmasse'
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'embear/vim-localvimrc'
Plug 'godlygeek/tabular' " dependency for plasticboy/vim-markdown
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'derekprior/vim-trimmer'
Plug 'duggiefresh/vim-easydir'
Plug 'sbdchd/neoformat'
Plug 'gcmt/wildfire.vim' "select the closest text object


" Colors
Plug 'chriskempson/base16-vim'
Plug 'scwood/vim-hybrid'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'sass'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'sass'] }

" Move
Plug 'matze/vim-move'
let g:move_map_keys = 0
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp

" Autocomplete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --all' }

" TypeScript
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'peitalin/vim-jsx-typescript', { 'for': ['typescript'] }

" JavaScript
Plug 'marijnh/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }

call plug#end()
