let mapleader="\<SPACE>"

set autoread
set nobackup
set noswapfile
set nowritebackup
set undodir=~/.vim/undo
set undofile

set number
set rnu
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

nnoremap <silent> <leader><cr> :nohlsearch<CR><C-L>
imap ii <Esc>
imap jk <Esc>

" copy to system clipboard
set clipboard=unnamed

" save shortcuts
map <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>
nmap <c-s> <Esc>:w<CR>

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
nmap <silent> <leader>gs :terminal tig status<CR>

call plug#begin('~/.vim/plugged')

Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
let g:notes_directories = ['~/Google Drive/Notes']


Plug 'Raimondi/VimRegStyle'
Plug 'dahu/Asif'
Plug 'dahu/vimple'
Plug 'dahu/vim-asciidoc'
Plug 'moll/vim-node'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'Olical/vim-enmasse'
Plug 'Slava/vim-spacebars'
Plug 'Valloric/MatchTagAlways'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'benekastah/neomake'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-jade'
Plug 'dkprice/vim-easygrep'
Plug 'easymotion/vim-easymotion'
Plug 'einars/js-beautify'
Plug 'embear/vim-localvimrc'
Plug 'gabrielpoca/vim-snippets'
Plug 'gavocanov/vim-js-indent'
Plug 'gcmt/wildfire.vim'
Plug 'godlygeek/tabular'
Plug 'guns/vim-clojure-static'
Plug 'hail2u/vim-css3-syntax'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'kassio/neoterm'
Plug 'luochen1990/rainbow'
Plug 'maksimr/vim-jsbeautify'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'reedes/vim-pencil'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scwood/vim-hybrid'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomasr/molokai'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" => Airline
set laststatus=2
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


" => Asciidoc
autocmd FileType adoc set tw=79|set wrap|set linebreak|set nolist


" => Vimple
let vimple_init_vn = 0


" => Rainbow
let g:rainbow_active = 1 


" => TernJS
let tern_is_show_argument_hints_enabled = 1
let tern_show_signature_in_pum = 1
let tern_map_keys = 1
" disable autopreview window
autocmd BufEnter * set completeopt-=preview


" => Neoterm
let g:neoterm_position = 'verical'
let g:neoterm_automap_keys = 'tt'
nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <leader>ts :TREPLSend<cr>
vnoremap <silent> <leader>ts :TREPLSend<cr>
" run set test lib
nnoremap <silent> <leader>ra :call neoterm#test#run('all')<cr>
nnoremap <silent> <leader>rt :call neoterm#test#run('file')<cr>
nnoremap <silent> <leader>rr :call neoterm#test#run('current')<cr>
nnoremap <silent> <leader>rl :call neoterm#test#rerun()<cr>
" hide/close terminal
nnoremap <silent> <leader>th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> <leader>tc :call neoterm#kill()<cr>


" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate


" Git commands
command! -nargs=+ Tg :T git <args>


" => JSX
let g:jsx_ext_required = 0


" => YCM
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\s{4}', 're!:\s+' ],
    \ }


" => FZF
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(blue)%C(bold)%cr%C(white)"'
nmap <leader>o :Buffers<cr>
nmap <leader>p :Files<cr>
nmap <leader>q :Ag<cr>
inoremap <C-p> <Esc>:Files<cr>
nnoremap <C-p> :Files<cr>


" => JavaScript
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufRead,BufNewFile *.jsx setfiletype javascript
autocmd FileType javascript setlocal omnifunc=tern#Complete
let g:used_javascript_libs = 'underscore,jquery,chai,handlebars'


" => Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_css_enabled_makers = []
autocmd! BufWritePost * Neomake


" => Theme
let g:rehash256 = 1
set background=dark
colorscheme molokai
"hi LineNr guibg=bg
"set foldcolumn=2
"hi foldcolumn guibg=bg
"hi VertSplit guibg=bg guifg=bg


" => NERDTree
let NERDTreeWinPos='right'
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0
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


" => Pull Request
" change all commits to squash except for the first
map <Leader>rs mzggjvG$:s/^pick/f<CR>


" => Buffers
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>


" => Spell
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
set complete+=kspell


" => Command Maps
nnoremap H 0
nnoremap L $


" => QuickScope
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


" Usage:
"
"   :Ginitpull [remote-name] [branch-name]
"
" Initiates a github pull request in the default browser, from the given
" branch name to master, on the given remote. Tab-completes both arguments.
"
" If called without any arguments, defaults to the "origin" remote and the
" current branch name, which is probably what you usually want.
"
command! -complete=custom,s:GinitpullComplete -nargs=* Ginitpull call s:Ginitpull(<f-args>)
function! s:Ginitpull(...)
  let remote_name = get(a:000, 0, 'origin')
  let branch_name = get(a:000, 1, '')

  try
    if branch_name == ''
      let branch_name = s:CurrentGitBranch()
    endif

    let github_path = s:GithubPath(remote_name)
  catch /./
    echoerr v:exception
  endtry

  call s:OpenURL('https://github.com/'.github_path.'/pull/new/'.branch_name)
endfunction

function! s:GithubPath(remote_name)
  for remote in split(system('git remote -v'), "\n")
    if remote =~ '^'.a:remote_name
      if remote =~ 'git@github.com'
        return substitute(remote, '.*git@github.com:\(.*\)\.git.*', '\1', '')
      elseif remote =~ 'https\?://github\.com'
        return substitute(remote, '.*https\?://github\.com/\(.*\)\.git.*', '\1', '')
      endif
    endif
  endfor

  throw 'No remote "'.a:remote_name.'" was found, or remote is not from github.'
endfunction

function! s:CurrentGitBranch()
  " Search upwards for relevant files
  let head_file    = findfile('.git/HEAD', ';')
  let dot_git_file = findfile('.git', ';')

  if filereadable(head_file)
    let head_ref = readfile(head_file)[0]
  elseif filereadable(dot_git_file)
    let module_file = readfile(dot_git_file)[0]
    let module_file = substitute(module_file, 'gitdir: \(.*\)', '\1/HEAD', '')
    let head_ref    = readfile(module_file)[0]
  else
    throw 'This doesn''t look like a git repository, neither .git/HEAD nor .git were found.'
  endif

  return substitute(head_ref, 'ref: refs/heads/\(.*\)', '\1', '')
endfunction

function! s:GinitpullComplete(argument_lead, command_line, cursor_position)
  if a:argument_lead != ''
    " then we're in the middle of an argument, remove it from the command-line
    let start_of_line = substitute(a:command_line, a:argument_lead.'$', '', '')
  else
    " just take the entire command-line
    let start_of_line = a:command_line
  end

  let arg_count = len(split(start_of_line, '\s\+'))

  if arg_count <= 1
    " first argument: remote
    let completions = s:TrimLines(system('git remote'))
  elseif arg_count == 2
    " second argument: branch
    let completions = substitute(system('git branch'), '\*\s*', '', 'g')
    let completions = s:TrimLines(completions)
  else
    " can't handle more than 2 arguments
    let completions = ''
  endif

  return completions
endfunction

function! s:OpenURL(url)
  let url = shellescape(a:url)

  if has('mac')
    silent call system('open '.url)
  elseif has('unix')
    if executable('xdg-open')
      silent call system('xdg-open '.url.' 2>&1 > /dev/null &')
    else
      echoerr "You need to install xdg-open to be able to open urls"
      return
    end
  else
    echoerr "Don't know how to open a URL on this system"
    return
  end

  echo "Opening ".url
endfunction

function! s:Trim(s)
  let s = a:s
  let s = substitute(s, '^\_s\+', '', '')
  let s = substitute(s, '\_s\+$', '', '')
  return s
endfunction

" Trim a list of items
function! s:TrimList(ss)
  return map(a:ss, 's:Trim(v:val)')
endfunction

" Trim each line in the given string
function! s:TrimLines(s)
  return join(s:TrimList(split(a:s, "\n")), "\n")
endfunction
