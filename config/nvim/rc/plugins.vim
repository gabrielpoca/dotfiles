call plug#begin('~/.vim/plugged')

Plug 'tidalcycles/vim-tidal'

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
Plug 'w0rp/ale'

" GIT
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive', { 'on': ['Gblame', 'Gstatus', 'Git'] }

" Colors
Plug 'morhetz/gruvbox'

" Languages
"Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'sass'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'sass'] }

" Autocomplete
function! InstallDeps(info)
  if a:info.status == 'installed' || a:info.force
    let extensions = ['coc-emmet',     \
    'coc-highlight', \
    'coc-css',       \
    'coc-yaml',      \
    'coc-ultisnips',  \
    'coc-tsserver',  \
    'coc-json',       \
    'coc-emoji'       \
    ]
    call coc#util#install()
    call coc#util#install_extension(extensions)
  endif
endfunction
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': function('InstallDeps')}

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx', 'typescript'] }

" Ruby
Plug 'tpope/vim-rails', { 'for': 'ruby' }

call plug#end()
