" exit terminal mode
tnoremap <C-e> <C-\><C-n>

" change settings in terminal
au TermOpen * setlocal nonumber norelativenumber wrap winhl=Normal:MyTerm signcolumn=

" vim-test settings
function! MyStrategy(cmd)
  exec 'lua require"repl".run_test("'.a:cmd.'")'
endfunction

let g:test#custom_strategies = {'echo': function('MyStrategy')}
let g:test#strategy = 'echo'
