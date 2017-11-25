function! neoformat#formatters#typescript#prettier() abort
  return {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin', '--single-quote', '--no-semi'],
        \ 'stdin': 1,
        \ }
endfunction
