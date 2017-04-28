let mapleader="\<SPACE>"

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

set ignorecase
set smartcase
set incsearch
set gdefault
set magic
set inccommand=nosplit

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

" terminal
autocmd TermOpen * set bufhidden=hide
tnoremap <Leader>e <C-\><C-n>
tnoremap <Leader>jk <C-\><C-n>
tnoremap <Leader>jj <C-\><C-n>

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin('~/.vim/plugged')

" => Writing
Plug 'jreybert/vimagit'
Plug 'ludovicchabant/vim-gutentags'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'embear/vim-localvimrc'
Plug 'gabrielpoca/vim-snippets'
Plug 'gcmt/wildfire.vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scwood/vim-hybrid'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'derekprior/vim-trimmer'
Plug 'duggiefresh/vim-easydir'

Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby', 'do': 'gem install neovim' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }

Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }

Plug 'slim-template/vim-slim', { 'for': 'slim' }

Plug 'jaawerth/nrun.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'marijnh/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'prettier/prettier', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'sass'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'sass'] }

Plug 'gabrielpoca/dotfiles', { 'rtp': 'vim/gabrielpoca' }

call plug#end()

" => UltiSnipps
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" => Alchemist
let g:alchemist_tag_disable = 1

" => Polyglot
let g:polyglot_disabled = ['js', 'jsx', 'markdown']

" => Deoplete
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 0
let g:deoplete#max_list = 20
let g:deoplete#auto_complete_delay = 100

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" Transparent editing of gpg encrypted files. Adapted from Wouter Hanegraaff
augroup encrypted
  au!
  autocmd BufReadPre,FileReadPre *.gpg.wiki set viminfo=
  autocmd BufReadPre,FileReadPre *.gpg.wiki set noswapfile noundofile nobackup
  autocmd BufReadPost,FileReadPost *.gpg.wiki '[,']!gpg2 --no-tty -d 2> /dev/null
  autocmd BufWritePre,FileWritePre *.gpg.wiki '[,']!gpg2 --default-recipient-self -ae 2>/dev/null
  autocmd BufWritePost,FileWritePost *.gpg.wiki u
augroup END

" => TernJS
let tern_is_show_argument_hints_enabled = 1
let tern_show_signature_in_pum = 1
let tern_map_keys = 1
" disable autopreview window
autocmd BufEnter * set completeopt-=preview

" => vim-test
let test#strategy = "neoterm"
let g:test#preserve_screen = 1

nnoremap <silent> <leader>ra :TestSuite<cr>
nnoremap <silent> <leader>rt :TestFile<cr>
nnoremap <silent> <leader>rr :TestNearest<cr>
nnoremap <silent> <leader>rl :TestLast<cr>

" => Neoterm
let g:neoterm_shell = 'zsh'
let g:neoterm_position = 'verical'
let g:neoterm_automap_keys = 'tt'
nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <leader>ts :TREPLSend<cr>
vnoremap <silent> <leader>ts :TREPLSend<cr>
" hide/close terminal
nnoremap <silent> <leader>th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> <leader>tk :call neoterm#kill()<cr>

" Git commands
command! -nargs=+ Tg :T git <args>
command! Tig :T tig status
nnoremap <silent> <leader>gs :Tig<cr>

" => JSX
let g:jsx_ext_required = 0

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

" => JavaScript
autocmd FileType javascript set formatprg=prettier\ --stdin
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufRead,BufNewFile *.jsx setfiletype javascript
" https://www.reddit.com/r/vim/comments/4kjgmz/weekly_vim_tips_and_tricks_thread_11/d3g6l8y
autocmd FileType javascript setl suffixesadd=.js,.json,.html
"autocmd FileType javascript setlocal omnifunc=tern#Complete
let g:used_javascript_libs = 'underscore,jquery,chai,handlebars'

" => Neomake
"let g:neomake_elixir_mix_maker = {
      "\ 'exe' : 'mix',
      "\ 'args': ['compile', '--warnings-as-errors'],
      "\ 'cwd': getcwd(),
      "\ 'errorformat':
      "\ '** %s %f:%l: %m,' .
      "\ '%f:%l: warning: %m'
      "\ }
"let g:neomake_elixir_enabled_makers = ['elixir']
"let g:neomake_elixir_elixir_maker = {
      "\ 'exe': 'elixirc',
      "\ 'args': [
        "\ '--ignore-module-conflict', '--warnings-as-errors',
        "\ '--app', 'mix', '--app', 'ex_unit',
        "\ '-o', '$TMPDIR', '%:p'
      "\ ],
      "\ 'errorformat':
          "\ '%E** %s %f:%l: %m,' .
          "\ '%W%f:%l'
      "\ }

let g:neomake_elixir_mix_maker = []
let g:neomake_elixir_enabled_makers = []
let g:neomake_css_enabled_makers = []
let g:neomake_place_signs_at_once = 1

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_markdown_enabled_makers = ['proselint']

let g:neomake_prose_maker = {
  \ 'exe': 'proselint',
  \ 'args': ['%:p'],
  \ 'errorformat': '%f:%l:%c:%m',
  \ }

au BufEnter *.js let b:neomake_javascript_eslint_exe = nrun#Which('eslint')
au BufEnter *.jsx let b:neomake_jsx_eslint_exe = nrun#Which('eslint')

autocmd! BufWinEnter,BufWritePost * Neomake

" => Theme
"if filereadable(expand("~/.vimrc_background"))
  "let base16colorspace=256
  "source ~/.vimrc_background
"endif
set background=dark
colorscheme hybrid
hi FoldColumn ctermbg=none

" => NERDTree
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0
"let NERDTreeHijackNetrw=1
map <silent> <Leader>n :NERDTreeToggle<cr>
map <silent> <Leader>f :NERDTreeFind<cr>
map <silent> <Leader>k :NERDTreeFocus<cr>

"NERDTree File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', 'none')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', 'none')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', 'none')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', 'none')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', 'none')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', 'none')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', 'none')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', 'none')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', 'none')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', 'none')
call NERDTreeHighlightFile('jsx', 'Red', 'none', '#ffa500', 'none')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', 'none')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', 'none')

" => Write Mode
function! WriteMode()
  setlocal nonumber
  setlocal norelativenumber
  setlocal complete+=kspell
  setlocal foldcolumn=10
  UniCycleOn
  HardPencil
  Voom markdown
endfunction

com! WM call WriteMode()

augroup remember_folds
  autocmd!
  autocmd BufWinLeave,BufLeave,WinLeave *.wiki mkview
  autocmd BufWinEnter *.wiki silent loadview
augroup END

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

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

" => Spell
autocmd BufRead,BufNewFile *.md setlocal complete+=kspell spell
autocmd FileType gitcommit setlocal complete+=kspell spell
