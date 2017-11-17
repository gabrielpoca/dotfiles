function! neoformat#formatters#javascript#prettier() abort
  return {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin', '--single-quote', '--trailing-comma es5'],
        \ 'stdin': 1,
        \ }
endfunction
