" linter
let g:neomake_ts_maker = {
  \ 'exe': 'tslint',
  \ 'args': ['%:p'],
  \ 'errorformat': 'ERROR: %f[%l\, %c]: %m',
  \ }


" prettier
function! neoformat#formatters#typescript#prettier() abort
  return {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin', '--single-quote', '--no-semi'],
        \ 'stdin': 1,
        \ }
endfunction

autocmd FileType *typescript* nnoremap <silent> <C-]> :YcmCompleter GoToDefinition<cr>
let g:neomake_typescript_enabled_makers = ['ts']
let g:neomake_tsx_enabled_makers = ['ts']
