lua require("terminal")

" exit terminal mode
tnoremap <C-e> <C-\><C-n>

" change settings in terminal
au TermOpen * setlocal nonumber norelativenumber wrap winhl=Normal:MyTerm

" neoterm settings
let g:neoterm_default_mod = 'vertical'
let g:neoterm_automap_keys = 'tt'
let g:neoterm_fixedsize = 1
let g:neoterm_autoscroll = 1

" toggle terminal split
nnoremap <silent> <leader>th :Ttoggle<cr>
" clear terminal
nnoremap <silent> <leader>tl :Tclear<cr>
" kill job running in terminal
nnoremap <silent> <leader>tk :Tkill<cr>

" vim-test settings
let test#strategy = "neoterm"

" run tests for whole test suite
nnoremap <silent> <leader>ra :TestSuite<cr>
" run tests for current file
nnoremap <silent> <leader>rt :TestFile<cr>
" run tests for current line
nnoremap <silent> <leader>rr :TestNearest<cr>
" re-run last test
nnoremap <silent> <leader>rl :TestLast<cr>
