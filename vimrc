" chagne the leader key to ,
let mapleader = ','

set wildignore=*.swp,*.bak,*.pyc,*.class

" to prevent the 'crontab: temp file must be edited in place' message
if $VIM_CRONTAB == "true"
	set nobackup
	set nowritebackup
	set backupskip=/tmp/*,/private/tmp/*" 
endif

" configuration for scss, https://github.com/cakebaker/scss-syntax.vim
au BufRead,BufNewFile *.scss set filetype=scss

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
call pathogen#infect() 

" set cursorline
set nocursorline

" Turn off vi compatibility mode
set nocompatible

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

" keep a backup file
" in ~/.vim/backup
set backup 
set backupdir=~/.vim/backup

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

" NERDTree configuration
let NERDTreeWinPos='right'
" NERDTree autoclose on only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Toggle NERDTreeTabs
" map <silent> nt :NERDTreeTabsToggle<cr>
" Toogle NERDTree
map <silent> nt :NERDTreeToggle<cr>

" Turn off search highlight
nmap <silent> <C-N> :silent noh<CR>

" User keys
map <c-s> :w<CR>
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>

" zen expand
let g:user_zen_expandabbr_key = '<c-e>'

" Tabs
imap ,t <Esc>:tabnew<CR>

" THEME
set background=light
syntax enable

" gui and terminal colorschemes
if has("gui_running")
	colorscheme github256
	"colorscheme ir_black
	set nowrap
	set guifont=Source\ Code\ Pro\ for\ Powerline:h12
	set guioptions=egmrt
	set guioptions-=r
else
	set guifont=Source\ Code\ Pro\ for\ Powerline:h12
  colorscheme github256
	"colorscheme solarized
endif

"set background=dark
" solarized options 
"let g:solarized_termcolors = 256
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
"colorscheme solarized

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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/fixtures/*,*/functional/*,*/.git/*,.git/*  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
let g:ctrlp_dont_split = 'nerdtree'

let g:multiedit_nomappings = 1


" indent file
map <leader>w mzgg=G`z<CR>
imap <leader>w <c-c>mzgg=G`z<CR>


" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
