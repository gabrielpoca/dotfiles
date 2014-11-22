set shell=/bin/bash " required for vundle with fish

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
set ttyscroll=3   " testing, should make it faster when scrolling is slow.
set ttymouse=xterm2
set relativenumber
set number
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
" set list listchars=tab:->,trail:·


" Per project .vimrc
set exrc
set secure 

" http://superuser.com/questions/244040/how-do-i-change-until-the-next-underscore-in-vim/244070#244070
set iskeyword-=-

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
Plugin 'altercation/vim-colors-solarized'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'plasticboy/vim-markdown'
Plugin 'bling/vim-airline'
Plugin 'gabrielpoca/vim-colorpack'
Plugin 'chriskempson/base16-vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'vim-scripts/JavaScript-Indent'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'duff/vim-scratch'
Plugin 'mattn/emmet-vim'
Plugin 'godlygeek/tabular'
Plugin 'wting/rust.vim'
Plugin 'elzr/vim-json'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'rizzatti/dash.vim'
Plugin 'zerowidth/vim-copy-as-rtf'
Plugin 'thoughtbot/vim-rspec'
Plugin 'jgdavey/tslime.vim'
Plugin 'henrik/vim-qargs'
Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on     " required!

" don't render italic, bold, links in HTML
let html_no_rendering=1

" use ru files like ruby
au BufRead,BufNewFile *.ru setfiletype ruby

" color scheme
set t_Co=16
set background=dark
colorscheme base16-default

" clipboard
set clipboard=unnamed

" for macvim
if has("gui_running")
  set guioptions=egmrt
  set guioptions-=r
  set guifont=Inconsolata\ for\ Powerline:h14
  set bg=dark
  set vb
  colorscheme base16-flat
endif

" powerline
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'
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

" Rspec
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

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

" Paste in paste mode
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" make + beahve like :
nnoremap . :
nnoremap + :

" make <leader>o and <leader>O add new line without going to insert mode
map <silent> <leader>o :put =''<cr>
map <silent> <leader>O :put! =''<cr>

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
