let mapleader="\<SPACE>"

so ~/.config/nvim/rc/plugins.vim
so ~/.config/nvim/rc/ruby.vim
so ~/.config/nvim/rc/javascript.vim
so ~/.config/nvim/rc/terraform.vim
so ~/.config/nvim/rc/colors.vim
so ~/.config/nvim/rc/statusline.vim
so ~/.config/nvim/rc/tree.vim
so ~/.config/nvim/rc/terminal.vim
so ~/.config/nvim/rc/search.vim
so ~/.config/nvim/rc/linter.vim
so ~/.config/nvim/rc/completion.vim
so ~/.config/nvim/rc/experiments.vim

set autoread
set nobackup
set noswapfile
set nowritebackup
set undodir=~/.vim/undo
set undofile

set rnu
set nu
set expandtab
set tabstop=2
set shiftwidth=2
set nowrap
set wildmenu
set wildmode=full

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
set synmaxcol=200
set cursorline
set cursorcolumn

set ignorecase
set smartcase
set incsearch
set gdefault
set inccommand=nosplit
set completeopt+=noselect,menuone,preview
set formatoptions+=j

set dictionary+=/usr/share/dict/words

" copy to system clipboard
set clipboard=unnamed

set hidden

" ESC
imap jk <Esc>

" save
map <c-s> :w<CR>
nmap <silent> <c-s> <Esc>:w<CR>

" pane navigation
nmap <BS> <C-W>h
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" => buffer shortcuts
nmap <C-q> :bp <BAR> bd #<CR>

" location list shortcuts
nnoremap <silent> <leader>ll :llast<CR>

" change all commits to squash except for the first
map <Leader>gs mzggjvG$:s/^pick/s<CR>

" get the pull request's description
map <leader>gd :r !git pr-description<CR>

" move in wrapped lines
nnoremap j gj
nnoremap k gk

" => multi cursors
let g:multi_cursor_exit_from_insert_mode = 0

" => trimmer
let g:trimmer_blacklist = ['markdown', 'md', 'make', 'vim']

" => polyglot
let g:polyglot_disabled = ['js', 'jsx', 'markdown', 'ts', 'tsx']

" => localvimrc
let g:localvimrc_whitelist=['/Users/gabriel/Projects/.*']
let g:localvimrc_sandbox=0