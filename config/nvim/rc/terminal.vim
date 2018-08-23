tnoremap <C-e> <C-\><C-n>
tnoremap jk <C-\><C-n>

au TermOpen * setlocal nonumber norelativenumber

" => terminal
let g:neoterm_default_mod = 'vertical'
let g:neoterm_automap_keys = 'tt'
let g:neoterm_fixedsize = 1
let g:neoterm_size = 60
let g:neoterm_autoscroll = 1

nnoremap <silent> <leader>th :Ttoggle<cr>
nnoremap <silent> <leader>tl :Tclear<cr>
nnoremap <silent> <leader>tk :Tkill<cr>

let test#strategy = "neoterm"
nnoremap <silent> <leader>ra :TestSuite<cr>
nnoremap <silent> <leader>rt :TestFile<cr>
nnoremap <silent> <leader>rr :TestNearest<cr>
nnoremap <silent> <leader>rl :TestLast<cr>
