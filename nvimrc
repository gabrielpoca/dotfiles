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
nnoremap Q :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
imap ii <Esc>

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

call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'kien/ctrlp.vim'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

Plug 'bling/vim-airline'
Plug 'scwood/vim-hybrid'

Plug 'Slava/vim-spacebars'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'

call plug#end()

" => Airline
set laststatus=2
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline_theme= 'simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


" => TernJS
let tern#is_show_argument_hints_enabled = 0
let tern_show_signature_in_pum = 0
let tern_map_keys = 0


" => YCM
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\s{4}', 're!:\s+' ],
    \ }


" => CtrlP
nmap <leader>o :CtrlPBuffer<cr>
nmap <leader>p :CtrlP<cr>
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


" => Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_css_enabled_makers = ['scss_lint']
autocmd! BufWritePost * Neomake


" => Theme
let g:hybrid_use_Xresources = 1
colorscheme hybrid


" => NERDTree
let NERDTreeWinPos='left'
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0
map <silent> <Leader>n :NERDTreeToggle<cr>
map <silent> <Leader>k :NERDTreeFocus<cr>


" => Pull Request
" change all commits to squash except for the first
map <Leader>rs mzggjvG$:s/^pick/s<CR>


" => Buffers
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>
