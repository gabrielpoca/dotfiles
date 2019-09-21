" pane navigation
nmap <BS> <C-W>h
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" => buffer shortcuts
nmap <C-q> :bp <BAR> bd #<CR>

" fzfz jumps to the existing window if possible
let g:fzf_buffers_jump = 1

" move in wrapped lines
nnoremap j gj
nnoremap k gk

" only jump to a closing pair on the same line
let g:AutoPairsMultilineClose = 1

" open alternate file defined in vim-projectionist
nmap <leader>fa :A<cr>
nmap <leader>fv :AV<cr>

" search for open buffers
nmap <leader>o :Buffers<cr>

" search for files
nmap <leader>p :Files<cr>

" search for lines in open buffers
nmap <leader>i :Lines<cr>

" clear search
nnoremap <silent> <leader><cr> :nohlsearch<CR><C-L>

" search word under cursor
nnoremap <silent> <Leader>fw :Ag <C-R><C-W><CR>

" search for something
nnoremap <silent> <Leader>ff :Ag 

" insert mode completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" default heuristics for projectionist
let g:projectionist_heuristics = {
      \ "package.json": {
      \   'src/*.js': {'alternate': '{}.test.js', 'type': 'source'},
      \   'src/*.test.js': {'alternate': 'src/{}.js', 'type': 'test'}
      \ },
      \ "mix.exs": {
      \   'lib/*.ex': {'alternate': 'test/{}_test.exs', 'type': 'source'},
      \   'test/*_test.exs': {'alternate': 'lib/{}.ex', 'type': 'test'}
      \ }}

let g:NERDTreeWinPos = "left"
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeStatusline = "%{''}"

" toggle nerdtree
nnoremap <silent> <leader>nn :NERDTreeToggle<cr>

" find in nerdtree
nnoremap <silent> <leader>nf :NERDTreeFind<cr>

" disable cursorcolumn and cursorline in nerdtree
au FileType nerdtree set nocursorline
au FileType nerdtree set nocursorcolumn


function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  "Set the position, size, etc. of the floating window.
  "The size configuration here may not be so flexible, and there's room for further improvement.
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col + 30,
        \ 'width': width * 2 / 3,
        \ 'height': height / 2
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  "Set Floating Window Highlighting
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

"Let the input go up and the search list go down
let $FZF_DEFAULT_OPTS = '--layout=reverse'

"Open FZF and choose floating window
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
