" prettier
function! neoformat#formatters#typescript#prettier() abort
  return {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin', '--single-quote', '--no-semi'],
        \ 'stdin': 1,
        \ }
endfunction

let g:neomake_typescript_enabled_makers = ['ts']
let g:neomake_tsx_enabled_makers = ['ts']
