" Jump to the existing window if possible
let g:fzf_buffers_jump = 1

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


let g:projectionist_heuristics = {
      \ "package.json": {
      \   'src/*.js': {'alternate': '{}.test.js', 'type': 'source'},
      \   'src/*.test.js': {'alternate': 'src/{}.js', 'type': 'test'}
      \ },
      \ "mix.exs": {
      \   'lib/*.ex': {'alternate': 'test/{}_test.exs', 'type': 'source'},
      \   'test/*_test.exs': {'alternate': 'lib/{}.ex', 'type': 'test'}
      \ }}
