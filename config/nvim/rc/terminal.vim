tnoremap <C-e> <C-\><C-n>
tnoremap jj <C-\><C-n>
tnoremap jk <C-\><C-n>

au TermOpen * setlocal nonumber norelativenumber

" => neoterm
let g:neoterm_shell = 'zsh'
let g:neoterm_position = 'verical'
let g:neoterm_automap_keys = 'tt'
vnoremap <silent> <leader>ts :TREPLSend<cr>
nnoremap <silent> <leader>th :call neoterm#close()<cr>
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
nnoremap <silent> <leader>tk :call neoterm#kill()<cr>

" => test
let test#strategy = "neoterm"
nnoremap <silent> <leader>ra :TestSuite<cr>
nnoremap <silent> <leader>rt :TestFile<cr>
nnoremap <silent> <leader>rr :TestNearest<cr>
nnoremap <silent> <leader>rl :TestLast<cr>
