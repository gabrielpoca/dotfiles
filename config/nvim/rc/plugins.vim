call plug#begin('~/.vim/plugged')

" => Writing
Plug 'reedes/vim-pencil'
Plug 'vim-voom/VOoM'

Plug 'farmergreg/vim-lastplace'
Plug 'Olical/vim-enmasse'
Plug 'sheerun/vim-polyglot'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'w0rp/ale'
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
Plug 'tpope/vim-surround'
Plug 'derekprior/vim-trimmer'
Plug 'sbdchd/neoformat'
Plug 'gcmt/wildfire.vim' "select the closest text object

" Colors
Plug 'scwood/vim-hybrid'

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'sass'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'sass'] }

" Autocomplete
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" TypeScript
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'peitalin/vim-jsx-typescript', { 'for': ['typescript'] }

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Ruby
Plug 'tpope/vim-rails', { 'for': 'ruby' }

call plug#end()
