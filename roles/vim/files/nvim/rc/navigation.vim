lua require("navigation")

" pane navigation
nmap <BS> <C-W>h
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" => buffer shortcuts
"nmap <C-q> :bp <BAR> bd #<CR>
map <C-q> :close<CR>
tnoremap <C-q> <C-\><C-n>:close<CR>

" move in wrapped lines
nnoremap j gj
nnoremap k gk

" only jump to a closing pair on the same line
let g:AutoPairsMultilineClose = 1

inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
