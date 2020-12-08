let mapleader="\<SPACE>"

so ~/.config/nvim/rc/plugins.vim

lua require("global")
lua require("tests")
lua require("repl")
lua require("terminal")
lua require("find_replace")

so ~/.config/nvim/rc/git.vim
so ~/.config/nvim/rc/colors.vim
so ~/.config/nvim/rc/statusline.vim
so ~/.config/nvim/rc/terminal.vim
so ~/.config/nvim/rc/navigation.vim
so ~/.config/nvim/rc/completion.vim
so ~/.config/nvim/rc/languages.vim
so ~/.config/nvim/rc/experiments.vim
so ~/.config/nvim/rc/writing.vim

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
set wildoptions=pum
set pumblend=20
set lazyredraw

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

set ignorecase
set smartcase
set incsearch
set gdefault
set inccommand=nosplit
set completeopt+=noselect,menuone,preview
set formatoptions+=j
set pyxversion=0

set dictionary+=/usr/share/dict/words

" copy to system clipboard
set clipboard=unnamed

set hidden

" ESC
"imap jk <Esc>

" save
map <c-s> :w<CR>
nmap <silent> <c-s> <Esc>:w<CR>

" => multi cursors
let g:multi_cursor_exit_from_insert_mode = 0

" => trimmer
let g:trimmer_blacklist = ['markdown', 'javascript', 'typescript', 'elixir', 'vim']

" => polyglot
let g:polyglot_disabled = ['json']
let g:terraform_fmt_on_save=1
let g:typescript_indent_disable = 1
let g:vim_markdown_folding_disabled = 1

" => localvimrc
let g:localvimrc_whitelist=['/Users/gabrielpoca/Developer/.*']
let g:localvimrc_sandbox=0

" => resize splits when vim is resized
autocmd VimResized * wincmd =

if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=wipe'"
endif
