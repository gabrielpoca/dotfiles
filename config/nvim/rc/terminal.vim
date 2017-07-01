"autocmd TermClose * bd!|q " quit when a terminal closes instead of showing exit code and waiting
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
autocmd TermOpen * set bufhidden=hide
tnoremap <C-e> <C-\><C-n>

" => Neoterm
let g:neoterm_shell = 'zsh'
let g:neoterm_position = 'verical'
let g:neoterm_automap_keys = 'tt'
nnoremap <silent> <f10> :TREPLSendFile<cr>
vnoremap <silent> <leader>ts :TREPLSend<cr>
nnoremap <silent> <leader>th :call neoterm#close()<cr>
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
nnoremap <silent> <leader>tk :call neoterm#kill()<cr>
