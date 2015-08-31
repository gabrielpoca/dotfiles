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
set relativenumber
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

Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-projectionist'
Plugin 'bronson/vim-visual-star-search'
Plugin 'gcmt/wildfire.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'henrik/vim-qargs'
Plugin 'mattn/emmet-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-scripts/greplace.vim'
Plugin 'unblevable/quick-scope'  

Plugin 'digitaltoad/vim-jade'
Plugin 'gabrielpoca/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
"Plugin 'juvenn/mustache.vim'
Plugin 'Slava/vim-spacebars'
Plugin 'moll/vim-node'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/syntastic'
Plugin 'slim-template/vim-slim'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'

Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'honza/vim-snippets'
Plugin 'marijnh/tern_for_vim'

Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'

Plugin 'benmills/vimux'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'duff/vim-scratch'
Plugin 'jgdavey/tslime.vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'szw/vim-g'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-fugitive'

Plugin 'amix/vim-zenroom2'
Plugin 'gabrielpoca/vim-language-shortcuts'
Plugin 'junegunn/goyo.vim'
Plugin 'nicholaides/words-to-avoid.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'luochen1990/rainbow'

call vundle#end()
filetype plugin indent on     " required!

" don't render italic, bold, links in HTML
let html_no_rendering=1

set t_ut=
set background=dark
set t_Co=256
"let base16colorspace=256

let g:hybrid_use_Xresources = 1
colorscheme hybrid

" clipboard
set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => QuickScope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
vnoremap <expr> <silent> f Quick_scope_selective('f')
vnoremap <expr> <silent> F Quick_scope_selective('F')
vnoremap <expr> <silent> t Quick_scope_selective('t')
vnoremap <expr> <silent> T Quick_scope_selective('T')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline_powerline_fonts = 1
let g:airline_theme='base16'
let g:airline_section_z=''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => react
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:jsx_ext_required = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => rainbow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let rainbow_colors = ['214','160','DarkGreen','DarkBlue','DarkRed']
let g:rainbow_active = 1
let g:rainbow_conf = {
      \   'ctermfgs': rainbow_colors
      \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""a
" => syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_async=1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_html_checkers=['']
let g:syntastic_slim_checkers=['']
"let g:syntastic_mode_map = { 'passive_filetypes': ['sass', 'scss'] }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctrlp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <Leader>p :CtrlP<cr>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ar'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/bower_components/*
set wildignore+=*/platforms/android/*,*/platforms/ios/*,*/bower_components/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_dont_split = 'nerdtree'
let g:multiedit_nomappings = 1
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  unlet g:ctrlp_user_command
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeWinPos='left'
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0

map <silent> <Leader>n :NERDTreeToggle<cr>
map <silent> <Leader>k :NERDTreeFocus<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => HTML5
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GIST
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable AutoComplPop.
set completeopt-=preview
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#sources#omni#functions')
  let g:neocomplete#sources#omni#functions = {}
endif

let g:neocomplete#sources#omni#functions.javascript = 'tern#Complete'
let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'

let g:tern#is_show_argument_hints_enabled = 0
let g:tern_show_signature_in_pum = 1
let g:tern_map_keys = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neosnippet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
  set conceallevel=2 concealcursor=niv
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => OMNI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd FileType css,scss,sass setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType javascript syntax clear jsFuncBlock
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd BufRead,BufNewFile *.ru setfiletype ruby
autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.md  setf markdown

" -------------------------------------------------------------------
" -------------------------------------------------------------------
"
" SHORTCUTS
"
" -------------------------------------------------------------------
" -------------------------------------------------------------------

" VIMUX
map <Leader>rp :VimuxPromptCommand<CR>
map <Leader>rl :VimuxRunLastCommand<CR>
map <Leader>ri :VimuxInspectRunner<CR>
map <Leader>rx :VimuxCloseRunner<CR>
map <Leader>rs :VimuxInspectRunner<CR>

" TERN
map <Leader>td :TernDef
map <Leader>tt :TernDefPreview
map <Leader>tr :TernRefs
map <Leader>te :TernRename

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

" maps jk to esc
inoremap jk <esc>

" move to end and begining of line
nnoremap H 0
nnoremap L $

" open TIL file
command TIL tabe~/Google\ Drive/TIL.markdown

" search word under curso
nnoremap Q :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" MACVIM
" ---------------------------------------------------------

if has("gui_running")
  "colorscheme base16-ashes
  set guifont=Inconsolata-dz\ for\ Powerline:h13
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
  "call LanguageEN()
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
