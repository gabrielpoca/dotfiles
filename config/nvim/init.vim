let mapleader="\<SPACE>"

so ~/.config/nvim/rc/plugins.vim
so ~/.config/nvim/rc/javascript.vim
so ~/.config/nvim/rc/typescript.vim
so ~/.config/nvim/rc/wiki.vim
so ~/.config/nvim/rc/colors.vim
so ~/.config/nvim/rc/status.vim
so ~/.config/nvim/rc/writing.vim
so ~/.config/nvim/rc/tree.vim
so ~/.config/nvim/rc/terminal.vim

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

set ignorecase
set smartcase
set incsearch
set gdefault
set magic
set inccommand=nosplit
set completeopt+=noselect,menu,preview

set dictionary+=/usr/share/dict/words

nnoremap <silent> <leader><cr> :nohlsearch<CR><C-L>
imap ii <Esc>
imap jk <Esc>

" copy to system clipboard
set clipboard=unnamed

" save shortcuts
map <c-s> :w<CR>
nmap <silent> <c-s> <Esc>:w<CR>

" pane navigation shortcuts
nmap <BS> <C-W>h
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" move in wrapped lines
nnoremap j gj
nnoremap k gk

" => YouCompleteMe
let g:ycm_server_python_interpreter = '/usr/local/bin/python'


" => UltiSnipps
let g:UltiSnipsExpandTrigger="<c-o>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'


" => Trimmer
let g:trimmer_blacklist = ['markdown', 'md', 'make']


" => Alchemist
let g:alchemist_tag_disable = 1


" => Polyglot
let g:polyglot_disabled = ['js', 'jsx', 'markdown', 'ts', 'tsx']


" => Localvimrc
let g:localvimrc_whitelist=['/Users/gabriel/Projects/.*']
let g:localvimrc_sandbox=0


" => Neoformat
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1


" => Test
let test#strategy = "neoterm"
let g:test#preserve_screen = 1

nnoremap <silent> <leader>ra :TestSuite<cr>
nnoremap <silent> <leader>rt :TestFile<cr>
nnoremap <silent> <leader>rr :TestNearest<cr>
nnoremap <silent> <leader>rl :TestLast<cr>


" => FZF
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(blue)%C(bold)%cr%C(white)"'
nmap <leader>o :Buffers<cr>
nmap <leader>p :Files<cr>
inoremap <C-p> <Esc>:Files<cr>
nnoremap <C-p> :Files<cr>
" search word under cursor
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
let g:fzf_tags_command = '/usr/local/bin/ctags'


" => Gutentag
let g:gutentags_ctags_executable='/usr/local/bin/ctags'
let g:gutentags_ctags_exclude=['*.js','*.jsx']


" => Neomake
let g:neomake_css_enabled_makers = []
let g:neomake_elixir_enabled_makers = []
let g:neomake_elixir_mix_maker = []
let g:neomake_place_signs_at_once = 1

autocmd! BufWinEnter,BufWritePost * Neomake

" => Pull Request
" change all commits to squash except for the first
map <Leader>gs mzggjvG$:s/^pick/s<CR>
map <leader>gd :r !git pr-description<CR>


" => Buffers
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <C-q> :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

