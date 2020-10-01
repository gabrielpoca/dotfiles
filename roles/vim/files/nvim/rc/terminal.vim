" exit terminal mode
tnoremap <C-e> <C-\><C-n>

" change settings in terminal
au TermOpen * setlocal nonumber norelativenumber wrap winhl=Normal:MyTerm signcolumn=

" neoterm settings
let g:neoterm_default_mod = 'vertical'
let g:neoterm_automap_keys = 'tt'
let g:neoterm_fixedsize = 1
let g:neoterm_autoscroll = 1

" vim-test settings
let test#strategy = "neoterm"
