set nocompatible


" ctrl-s    			: save document
" ctrl-p    			: ctrlp plugin open
" nt        			: open nerdtree
" gn        			: go to nedtree
" tt        			: open tagbar
" ctrl-e    			: zen expand
" leader+w        : indent file
" leader+leader+w : easymotion

" chagne the leader key to ,
let mapleader = ","

nnoremap <leader>ln :NumbersToggle<CR>
let g:enable_numbers = 0
"nnoremap <F4> :NumbersOnOff<CR>

set wildignore=*.swp,*.bak,*.pyc,*.class

set nobackup
set noswapfile

" to prevent the 'crontab: temp file must be edited in place' message
if $VIM_CRONTAB == "true"
  set nowritebackup
  set backupskip=/tmp/*,/private/tmp/*" 
endif

" configuration for scss, https://github.com/cakebaker/scss-syntax.vim
au BufRead,BufNewFile *.scss set filetype=scss
" set filetype for scss.erb and js.erb, 
" http://stackoverflow.com/questions/8413781/automatically-set-multiple-file-types-in-filetype-if-a-file-has-multiple-exten
autocmd BufRead,BufNewFile *.scss.erb setlocal filetype=scss.eruby
autocmd BufRead,BufNewFile *.js.erb setlocal filetype=javascript.eruby

" Vim-powerline configuration
set encoding=utf-8 " Necessary to show Unicode glyphs
set laststatus=2 " The prevent: The statusline is hidden/only appears in split windows!

" Disable bell
set vb

" Temporary fileslate dir
set directory=~/.vim/tmp

" entable mouse scroll
set mouse=a

" pathogen
set nocp
"call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" set cursorline
set nocursorline

" Presever the column during motion
set nostartofline

" Show line numbers (off = set nonu)
set nu

" Turn off message 'Thanks for flying vim'
set title

" Use incremental search
set incsearch

" Highlight search results
" set hlsearch

" Allow Vim to manage multiple buffers efectively
" 1. The current buffer can be put to the background without writing to disk
" 2. When a background buffer becomes current again, marks and undo-history are remembered
set hidden

" Boost history (20 to 1000)
set history=1000

" persistent undo
" allows to undo even after closing vim or even
" shutting down the computer
set undofile
set undodir=~/.vim/undo

" remember some stuff after quiting vim:
" marks, registers, searches, buffer list
set viminfo='20,<50,s10,h,%

" use backspace as a normal app
set backspace=indent,eol,start

" search is not case sensitive
set ignorecase

if &t_Co > 2 || has("gui_running")
  " switch syntax highlighting on, when the terminal has colors
  syntax on
end

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" auto indent when editing
set autoindent
set smartindent

" Use plugins according to iletypes
filetype indent on
filetype plugin on
filetype on
filetype plugin indent on

" Tagbar
map <silent> tt :TagbarToggle<cr>

" NERDTree configuration
let NERDTreeWinPos='left'
" NERDTree autoclose on only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Toggle NERDTreeTabs
"map <silent> nt :NERDTreeTabsToggle<cr>
" Toogle NERDTree
map <silent> nt :NERDTreeToggle<cr>
map <silent> gn :NERDTreeFocus<cr>

" Turn off search highlight
nmap <silent> <C-N> :silent noh<CR>

" Use ctrl-s to save in any mode
map <c-s> :w<CR>
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>

" zen expand
let g:user_zen_expandabbr_key = '<c-e>'

" THEME
set background=light
syntax enable

set guifont=Source\ Code\ Pro\ for\ Powerline:h12

" gui and terminal colorschemes
if has("gui_running")
  "colorscheme github256
  colorscheme solarized
  set nowrap
  set guioptions=egmrt
  set guioptions-=r
else
  " set term to 256color so it works on screen and tmux
  set term=xterm-256color
  colorscheme solarized
  set wrap
  set linebreak
endif

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" macvim tab navigation
if has("gui_macvim")
  map <D-1> :tabfirst<Cr>
  map <D-2> :tabfirst<Cr>gt
  map <D-3> :tabfirst<Cr>3gt
  map <D-4> :tabfirst<Cr>4gt
  map <D-5> :tabfirst<Cr>5gt
  map <D-6> :tabfirst<Cr>6gt
  map <D-7> :tabfirst<Cr>7gt
  map <D-8> :tabfirst<Cr>8gt
  map <D-9> :tabfirst<Cr>9gt
endif

" ctrlp plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/fixtures/*,*/functional/*  " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
let g:ctrlp_dont_split = 'nerdtree'
let g:multiedit_nomappings = 1
let g:ctrlp_use_caching = 0

" indent file
map <leader>w mzgg=G`z<CR>
imap <leader>w <c-c>mzgg=G`z<CR>

nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>l :wincmd l<CR>

" disable arrow keys
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
