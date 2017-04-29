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

" terminal
autocmd TermOpen * set bufhidden=hide
tnoremap <C-e> <C-\><C-n>

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin('~/.vim/plugged')

" => Writing
Plug 'vimwiki/vimwiki'
Plug 'rhysd/vim-grammarous'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-pencil'
Plug 'vim-voom/VOoM'

Plug 'Olical/vim-enmasse'
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'AndrewRadev/splitjoin.vim'
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
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'derekprior/vim-trimmer'
Plug 'duggiefresh/vim-easydir'
Plug 'sbdchd/neoformat'

Plug 'chriskempson/base16-vim'
Plug 'scwood/vim-hybrid'
Plug 'rakr/vim-one'
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'sass'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'sass'] }

" Complete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --all' }

" TypeScript
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

" JavaScript
Plug 'jaawerth/nrun.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'marijnh/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'gabrielpoca/dotfiles', { 'rtp': 'vim/gabrielpoca' }

call plug#end()


" => JavaScript
let g:tern#arguments = ["--persistent"]
let g:tern#command = ["tern"]
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0 " This do disable full signature type on autocomplete
let tern_is_show_argument_hints_enabled = 1
let tern_map_keys = 1
let tern_show_signature_in_pum = 1
let g:jsx_ext_required = 0

function! neoformat#formatters#javascript#prettier() abort
  return {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin', '--single-quote', '--trailing-comma es5'],
        \ 'stdin': 1,
        \ }
endfunction

autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufRead,BufNewFile *.jsx setfiletype javascript
autocmd FileType javascript setlocal completeopt-=preview
autocmd FileType javascript set formatprg=prettier\ --stdin
autocmd FileType javascript set suffixesadd=.js,.json,.html,.jsx
"autocmd! BufWritePre *.js Neoformat prettier " run prettier on save

let g:ycm_server_python_interpreter = '/usr/local/bin/python'

" => UltiSnipps
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" => Trimmer
let g:trimmer_blacklist = ['markdown', 'md', 'make']

" => Alchemist
let g:alchemist_tag_disable = 1

" => Polyglot
let g:polyglot_disabled = ['js', 'jsx', 'markdown']

" => Localvimrc
let g:localvimrc_whitelist=['/Users/gabriel/Projects/.*']
let g:localvimrc_sandbox=0

" => Neoformat
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" => VimWiki
let g:vimwiki_list = [
      \ {'path': '~/Projects/wiki/', 'syntax': 'markdown', 'ext': '.md'},
      \ {'path': '~/Projects/work_wiki/'}]
let g:vimwiki_folding='expr'

" => Typescript
autocmd BufRead,BufNewFile *.ts,*.d.ts setlocal filetype=typescript
autocmd BufRead,BufNewFile *.tsx setlocal filetype=typescript
autocmd FileType typescript setlocal completeopt-=preview completeopt+=menu
autocmd FileType typescript set suffixesadd=.js,.json,.html,.jsx,.ts,.tsx

" => Test
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
nnoremap <silent> <leader>th :call neoterm#close()<cr>
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
nnoremap <silent> <leader>tk :call neoterm#kill()<cr>

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
let g:neomake_typescript_tslint_maker = {
  \ 'args': ['%:p'],
  \ 'errorformat': 'ERROR: %f[%l\, %c]: %m',
  \ }

let g:neomake_prose_maker = {
  \ 'exe': 'proselint',
  \ 'args': ['%:p'],
  \ 'errorformat': '%f:%l:%c:%m',
  \ }

let g:neomake_css_enabled_makers = []
let g:neomake_elixir_enabled_makers = []
let g:neomake_elixir_mix_maker = []
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_markdown_enabled_makers = ['proselint']
let g:neomake_place_signs_at_once = 1
let g:neomake_tsx_enabled_makers = ['tslint']
let g:neomake_typescript_enabled_makers = ['tslint']

au BufEnter *.js let b:neomake_javascript_eslint_exe = nrun#Which('eslint')
au BufEnter *.jsx let b:neomake_jsx_eslint_exe = nrun#Which('eslint')

autocmd! BufWinEnter,BufWritePost * Neomake

" => Colors
set termguicolors
let g:one_allow_italics = 1
set background=dark
colorscheme one

" => NERDTree
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0
map <silent> <Leader>n :NERDTreeToggle<cr>
map <silent> <Leader>f :NERDTreeFind<cr>
map <silent> <Leader>k :NERDTreeFocus<cr>

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

" => Status Line
set statusline=
set statusline+=\  " Empty space
set statusline+=%< " Where to truncate line
set statusline+=%f " Path to the file in the buffer, as typed or relative to current directory
set statusline+=%{&modified?'\ +':''}
set statusline+=%{&readonly?'\ ':''}
set statusline+=%= " Separation point between left and right aligned items
set statusline+=\ %3p%% " Percentage through file in lines as in |CTRL-G|
set statusline+=\  " Empty space
