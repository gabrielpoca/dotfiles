set shell=/bin/bash " required for vundle with fish

let mapleader = "\<Space>"

set nocompatible
set nobackup
set nowritebackup
set noswapfile
set hlsearch      " highlight search
set noshowcmd     " show (partial) command in the last line of the screen
set noshowmode    " powerline shows the mode
set incsearch     " do incremental searching
set ignorecase    " case insensitive searching
set smartcase     " overrides ignorecase when pattern contains caps
set scrolloff=6   " Show 3 lines of context around the cursor.
set laststatus=2  " Always display the status line
set encoding=utf-8
set backspace=indent,eol,start
set splitright
set splitbelow
set nofoldenable
set mouse=a
set ttyfast
set ttyscroll=3   " testing, should make it faster when scrolling is slow.
set lazyredraw    " to avoid scrolling problems
set ttymouse=xterm2
set number
"set relativenumber
set guicursor+=a:blinkon0
set history=1000
set undofile
set undodir=~/.vim/undo
set autoread
set gdefault      " apply g on replace operations
set complete-=i   " Searching includes can be slow
set iskeyword-=-

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set shiftround
"set list listchars=tab:->,trail:·

" Per project .vimrc
set exrc
set secure 


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype off  " required by vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'othree/html5.vim'
Plugin 'gabrielpoca/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'slim-template/vim-slim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'moll/vim-node'
Plugin 'bronson/vim-visual-star-search'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'juvenn/mustache.vim'
Plugin 'duff/vim-scratch'
Plugin 'mattn/emmet-vim'
Plugin 'godlygeek/tabular'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'thoughtbot/vim-rspec'
Plugin 'jgdavey/tslime.vim'
Plugin 'henrik/vim-qargs'
"Plugin 'airblade/vim-gitgutter'
Plugin 'digitaltoad/vim-jade'
Plugin 'vim-scripts/greplace.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'junegunn/goyo.vim'
Plugin 'amix/vim-zenroom2'
Plugin 'nicholaides/words-to-avoid.vim'
Plugin 'gabrielpoca/vim-language-shortcuts'
Plugin 'w0ng/vim-hybrid'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on     " required!

" don't render italic, bold, links in HTML
let html_no_rendering=1

" color scheme
let g:solarized_termtrans = 16
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
set background=light
set t_ut=
colorscheme solarized

"set background=light
"set t_Co=16
"colorscheme base16-default
"
"let g:hybrid_use_iTerm_colors = 1
"colorscheme hybrid

" clipboard
set clipboard=unnamed

" powerline
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'
let g:airline_section_z=''

" ctrlp plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ar'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/bower_components/*
set wildignore+=*/platforms/android/*,*/platforms/ios/*,*/bower_components/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_dont_split = 'nerdtree'
let g:multiedit_nomappings = 1
let g:ctrlp_use_caching = 0

" Testing command
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" NERDTree configuration
let NERDTreeWinPos='left'
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0

" Html5 configuration
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0

" Gist
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
au BufRead,BufNewFile *.ru setfiletype ruby
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.md  setf markdown

" Neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" COMMANDS
" -------------------------------------------------------------------

" NERDTREE
map <silent> nt :NERDTreeToggle<cr>
map <silent> gn :NERDTreeFocus<cr>

" PULL REQUEST
" change all commits to squash except for the first
map <Leader>prs mzggjvG$:s/^pick/s<CR>

" SAVE
" Use ctrl-s to save in any mode
map <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>
nmap <c-s> <Esc>:w<CR>

" SPLIT
" move to split
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" BACKGROUND
map <silent> <leader>bd :set background=dark<cr>
map <silent> <leader>bl :set background=light<cr>

" SEARCH
" Hide highlighted terms
map <silent> <leader><cr> :noh<cr>

" Paste in paste mode
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" make ; beahve like :
nnoremap , :

" maps jk to esc
inoremap jk <esc>

" move to end and begining of line
nnoremap H 0
nnoremap L $

" open TIL file
command TIL tabe~/Google\ Drive/TIL.markdown


" MACVIM
" ---------------------------------------------------------

if has("gui_running")
  "colorscheme base16-ashes
  set guifont=Ubuntu\ Mono\ derivative\ Powerline\ Plus\ Nerd\ File\ Types:h14
  set guioptions=egmrt
  set guioptions-=r
  set noeb vb t_vb=
else
  set synmaxcol=128
endif

" FUNCTIONS
" ----------------------------------------------------------

" ZENMODE
nnoremap <silent> <leader>z :call Zenmode()<cr>

function! Zenmode()
  execute ':Goyo'
  set wrap
  set linebreak
  set nolist
  call MatchTechWordsToAvoid()
  call LanguageEN()
endfunctio

" INDENT
" dont' forget to run:
"   npm install -g esformatter
nnoremap <silent> <leader>i :call Format()<cr>

function! Format()
  " Preparation: save last search, and cursor position.
  let l:win_view = winsaveview()
  let l:last_search = getreg('/')
  let fileWorkingDirectory = expand('%:p:h')
  let currentWorkingDirectory = getcwd()
  execute ':lcd' . fileWorkingDirectory
  "execute ':silent normal! gg="G<cr>"'
  execute ':silent' . '%!esformatter'
  if v:shell_error
    undo
    "echo "esformatter error, using builtin vim formatter"
    " use internal formatting command
    execute ":silent normal! gg=G<cr>"
  endif
  " Clean up: restore previous search history, and cursor position
  execute ':lcd' . currentWorkingDirectory
  call winrestview(l:win_view)
  call setreg('/', l:last_search)
endfunction
