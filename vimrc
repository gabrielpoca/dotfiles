let mapleader = "\<Space>"

set nocompatible
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set noshowmode    " powerline shows the mode
set incsearch     " do incremental searching
set ignorecase    " case insensitive searching
set smartcase     " overrides ignorecase when pattern contains caps
set scrolloff=2   " Show 3 lines of context around the cursor.
set laststatus=2  " Always display the status line
set encoding=utf-8
set backspace=indent,eol,start
set splitright
set nofoldenable
set mouse=a
set ttyfast
set ttymouse=xterm2
set number
"set relativenumber
set guicursor+=a:blinkon0
set history=1000
set undofile
set undodir=~/.vim/undo
set autoread

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set shiftround
set list listchars=tab:->,trail:·

" http://superuser.com/questions/244040/how-do-i-change-until-the-next-underscore-in-vim/244070#244070
" set iskeyword-=_

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype off  " required by vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
Bundle 'gabrielpoca/ultisnips'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'othree/html5.vim'
Bundle 'mileszs/ack.vim'
Bundle 'danro/rename.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-rails'
Bundle 'slim-template/vim-slim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'rking/ag.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'plasticboy/vim-markdown'
Bundle 'bling/vim-airline'
Bundle 'gabrielpoca/vim-colorpack'
Bundle 'chriskempson/base16-vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'vim-scripts/JavaScript-Indent'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'AndrewRadev/writable_search.vim'
Bundle 'gcmt/wildfire.vim'
Bundle 'thoughtbot/vim-rspec'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'

filetype plugin indent on     " required!

" use ru files like ruby
au BufRead,BufNewFile *.ru setfiletype ruby

" Color scheme
set t_Co=16
set background=light
colorscheme base16-default

" Clipboard

if has("gui_running")
  set guioptions=egmrt
  set guioptions-=r
  set guifont=Inconsolata\ for\ Powerline:h14
  set bg=dark
  set vb
  colorscheme base16-flat
else
  set clipboard=unnamed
  "set lazyredraw " Wait to redraw
endif

" Rspec cofiguration
let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "!rspec -fd {spec}"
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>tn :call RunNearestSpec()<CR>
map <Leader>tl :call RunLastSpec()<CR>
map <Leader>ta :call RunAllSpecs()<CR>

" powerline
let g:airline_powerline_fonts = 1
"let g:airline_theme='powerlineish'
"let g:airline_left_sep=''
"let g:airline_right_sep=''
"let g:airline_section_z=''

" ctrlp plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ar'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
set wildignore+=*/platforms/android/*,*/platforms/ios/*,*/bower_components/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_dont_split = 'nerdtree'
let g:multiedit_nomappings = 1
let g:ctrlp_use_caching = 0
map <leader>bo :CtrlPBuffer<CR>
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

" disable folding
let g:vim_markdown_folding_disabled=1

" indent file
map <leader>fi mzgg=G`z

" change all commits to squash except for the first
map <Leader>prs mzggjvG$:s/^pick/s<CR>

" Use ctrl-s to save in any mode
map <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>
nmap <c-s> <Esc>:w<CR>

" fugitive shortcuts
noremap <leader>gb :Gblame<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gp :Git push<CR>

" move to split
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Toogle NERDTree
map <silent> nt :NERDTreeToggle<cr>
map <silent> gn :NERDTreeFocus<cr>

" Change background
map <silent> <leader>bd :set background=dark<cr>
map <silent> <leader>bl :set background=light<cr>

" simple vertical splits
map <leader>v <C-w>v

" Hide highlighted terms
map <silent> <leader><cr> :noh<cr>

" make + beahve like :
nnoremap . :
nnoremap + :

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

" Rails.vim custom navigation
" https://gist.github.com/jsteiner/5556217
let g:rails_gem_projections = {
      \ "draper": {
      \   "app/decorators/*_decorator.rb": {
      \     "command": "decorator",
      \     "affinity": "model",
      \     "test": "spec/decorators/%s_spec.rb",
      \     "related": "app/models/%s.rb",
      \     "template": "class %SDecorator < Draper::Decorator\nend"
      \   }
      \ }}

let g:rails_projections = {
      \ "app/presenters/*_presenter.rb": {
      \   "command": "presenter",
      \   "affinity": "model",
      \   "test": "spec/presenters/%s_spec.rb",
      \   "related": "app/models/%s.rb"
      \ }}

" close all hidden buffers
function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
