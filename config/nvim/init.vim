let mapleader="\<SPACE>"

so ~/.config/nvim/rc/plugins.vim
so ~/.config/nvim/rc/ruby.vim
so ~/.config/nvim/rc/javascript.vim
so ~/.config/nvim/rc/typescript.vim
so ~/.config/nvim/rc/colors.vim
so ~/.config/nvim/rc/statusline.vim
so ~/.config/nvim/rc/tree.vim
so ~/.config/nvim/rc/terminal.vim
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

" location list shortcuts
nnoremap <silent> <leader>ll :llast<CR>

" move in wrapped lines
nnoremap j gj
nnoremap k gk

" disable match parens, it doesn't work well with alacritty
let loaded_matchparen = 1

" => Deoplete
let g:deoplete#enable_at_startup = 1

function Multiple_cursors_before()
  let g:deoplete#disable_auto_complete = 1
endfunction
function Multiple_cursors_after()
  let g:deoplete#disable_auto_complete = 0
endfunction

let g:deoplete#file#enable_buffer_path = 1

" => Languge Server Protocol
set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
      \ 'javascript.jsx': ['/users/gabriel/.nvm/versions/node/v6.6.0/bin/javascript-typescript-stdio'],
      \ }

nnoremap <silent> <leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <leader>lr :call LanguageClient_textDocument_rename()<CR>

" => UltiSnipps
let g:UltiSnipsExpandTrigger="<c-o>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" => Trimmer
let g:trimmer_blacklist = ['markdown', 'md', 'make', 'vim']

" => Polyglot
let g:polyglot_disabled = ['js', 'jsx', 'markdown', 'ts', 'tsx']

" => Localvimrc
let g:localvimrc_whitelist=['/Users/gabriel/Projects/.*']
let g:localvimrc_sandbox=0

" => Neoformat
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" => FZF
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(blue)%C(bold)%cr%C(white)"'
nmap <leader>o :Buffers<cr>
nmap <leader>p :Files<cr>
inoremap <C-p> <Esc>:Files<cr>
nnoremap <C-p> :Files<cr>
" search word under cursor
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" hide status line inside fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" => ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'jsx': ['eslint'],
\   'css': ['stylelint'],
\   'scss': ['scsslint'],
\   'elixir': ['credo'],
\   'ruby': ['rubocop'],
\   'html': [],
\   'markdown': [],
\}

let g:ale_javascript_prettier_options = '--single-quote --no-semi'

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'javascript.jsx': ['prettier'],
\   'css': ['stylelint'],
\}

" => Pull Request
" change all commits to squash except for the first
map <Leader>gs mzggjvG$:s/^pick/s<CR>
map <leader>gd :r !git pr-description<CR>

" => Buffers
nmap <C-q> :bp <BAR> bd #<CR>
