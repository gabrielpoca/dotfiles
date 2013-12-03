let mapleader = ","

set nocompatible
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set noshowmode    " powerline shows the mode
set incsearch     " do incremental searching
"set hlsearch      " highlight searches (:noh to turn off)
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
set number
set guicursor+=a:blinkon0
set history=1000
set undofile
set undodir=~/.vim/undo

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set shiftround
set list listchars=tab:->,trail:·

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
Bundle 'gabrielpoca/vim-colorpack'
Bundle 'gabrielpoca/ultisnips'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
"Bundle 'powerline'
Bundle 'Lokaltog/powerline', {'rtp': '~/.powerline/bindings/vim'}
Bundle 'scrooloose/nerdcommenter'
Bundle 'othree/html5.vim'
Bundle 'mileszs/ack.vim'
Bundle 'danro/rename.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-cucumber'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-rails'
Bundle 'slim-template/vim-slim'
"Bundle 'Yggdroot/indentLine'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wesQ3/vim-windowswap'
Bundle 'thoughtbot/vim-rspec'
Bundle 'noahfrederick/vim-hemisu'
Bundle 'rking/ag.vim'
Bundle "pangloss/vim-javascript"
Bundle "stefanoverna/vim-i18n"
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-vividchalk'

filetype plugin indent on     " required!

" Color scheme
set t_Co=256
colorscheme solarized

if has("gui_running")
  set guioptions=egmrt
  set guioptions-=r
  set guifont=Source\ Code\ Pro\ for\ Powerline:h12
  set bg=light
  set vb
  colorscheme Tomorrow
else
  set clipboard=unnamed
  "set lazyredraw " Wait to redraw
endif

" ctrlp plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip  "MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_dont_split = 'nerdtree'
let g:multiedit_nomappings = 1
let g:ctrlp_use_caching = 1

" NERDTree configuration
let NERDTreeWinPos='left'
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0

" Html5 configuration
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0

" moves selected string to i18n
vmap <Leader>z :call I18nTranslateString()<CR>

" indent file
map <leader>fi mzgg=G`z<CR>

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
map <silent> nt :NERDTreeTabsToggle<cr>
map <silent> gn :NERDTreeFocus<cr>

" Change background
map <silent> <leader>bd :set background=dark<cr>
map <silent> <leader>bl :set background=light<cr>

" simple vertical splits
map <leader>v <C-w>v

" Hide highlighted terms
map <silent> <leader><cr> :noh<cr>

" make + beahve like :
nnoremap + :

let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>fs :wincmd l<CR>:call WindowSwap#MarkWindowSwap()<CR>:wincmd h<CR>:call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>

" Rspec.vim mappings
map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>
let g:rspec_command = "zeus rspec {spec}"

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
