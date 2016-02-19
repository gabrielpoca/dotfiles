let mapleader="\<SPACE>"

set autoread
set nobackup
set noswapfile
set nowritebackup
set undodir=~/.vim/undo
set undofile

set number
set rnu
set expandtab
set tabstop=2
set shiftwidth=2

set splitbelow
set splitright

if !&scrolloff
  set scrolloff=3
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline
set nostartofline

set ignorecase
set smartcase
set incsearch
set gdefault
set magic

nnoremap <silent> <leader><cr> :nohlsearch<CR><C-L>
imap ii <Esc>
imap jj <Esc>
imap jk <Esc>

" copy to system clipboard
set clipboard=unnamed

" save shortcuts
map <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>
nmap <c-s> <Esc>:w<CR>

" pane navigation shortcuts
nmap <BS> <C-W>h
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" move in wrapped lines
nnoremap j gj
nnoremap k gk

" terminal
autocmd TermOpen * set bufhidden=hide
tnoremap <Leader>e <C-\><C-n> 
tnoremap <Leader>jk <C-\><C-n> 
tnoremap <Leader>jj <C-\><C-n> 
nmap <silent> <leader>gs :terminal tig status<CR>

call plug#begin('~/.vim/plugged')

Plug 'kassio/neoterm'

Plug 'rking/ag.vim'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Olical/vim-enmasse'
Plug 'Slava/vim-spacebars'
Plug 'Valloric/MatchTagAlways'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'benekastah/neomake'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-jade'
Plug 'dkprice/vim-easygrep'
Plug 'easymotion/vim-easymotion'
Plug 'einars/js-beautify'
Plug 'embear/vim-localvimrc'
Plug 'gabrielpoca/vim-snippets'
Plug 'gavocanov/vim-js-indent'
Plug 'gcmt/wildfire.vim'
Plug 'godlygeek/tabular'
Plug 'guns/vim-clojure-static'
Plug 'hail2u/vim-css3-syntax'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'luochen1990/rainbow'
Plug 'maksimr/vim-jsbeautify'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scwood/vim-hybrid'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomasr/molokai'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" => Airline
set laststatus=2
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


" => Ag
nnoremap <leader>q :Ag<SPACE>


" => Rainbow
let g:rainbow_active = 1 


" => TernJS
let tern_is_show_argument_hints_enabled = 0
let tern_show_signature_in_pum = 1
let tern_map_keys = 0
" disable autopreview window
autocmd BufEnter * set completeopt-=preview


" => JSX
let g:jsx_ext_required = 0


" => YCM
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\s{4}', 're!:\s+' ],
    \ }


" => CtrlP
nmap <leader>o :CtrlPBuffer<cr>
nmap <leader>p :CtrlP<cr>
nmap <leader>i :CtrlPMRU<cr>
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_dont_split = 'nerdtree'
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'find %s -type f'
let g:multiedit_nomappings = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(zip|so)$'
  \ }

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  unlet g:ctrlp_user_command
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


" => JavaScript
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd FileType javascript setlocal omnifunc=tern#Complete
let g:used_javascript_libs = 'underscore,jquery,chai,handlebars'


" => AG
nnoremap <leader>g :Ag


" => Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_css_enabled_makers = []
autocmd! BufWritePost * Neomake


" => Theme
let g:rehash256 = 1
colorscheme molokai


" => NERDTree
let NERDTreeWinPos='right'
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0
map <silent> <Leader>n :NERDTreeToggle<cr>
map <silent> <Leader>f :NERDTreeFind<cr>
map <silent> <Leader>k :NERDTreeFocus<cr>


" => Pull Request
" change all commits to squash except for the first
map <Leader>rs mzggjvG$:s/^pick/s<CR>


" => Buffers
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>


" => Spell
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
set complete+=kspell


" => Command Maps
nnoremap H 0
nnoremap L $


" => QuickScope
" Insert into your .vimrc after quick-scope is loaded.
" Obviously depends on <https://github.com/unblevable/quick-scope> being installed.

function! Quick_scope_selective(movement)
  let needs_disabling = 0
  if !g:qs_enable
    QuickScopeToggle
    redraw
    let needs_disabling = 1
  endif

  let letter = nr2char(getchar())

  if needs_disabling
    QuickScopeToggle
  endif

  return a:movement . letter
endfunction

let g:qs_enable = 0

nnoremap <expr> <silent> f Quick_scope_selective('f')
nnoremap <expr> <silent> F Quick_scope_selective('F')
nnoremap <expr> <silent> t Quick_scope_selective('t')
nnoremap <expr> <silent> T Quick_scope_selective('T')
