function! neoformat#formatters#css#enabled() abort
    return ['styelint']
endfunction

function! neoformat#formatters#css#stylelint() abort
    return {
        \ 'exe': 'stylelint',
        \ 'args': ['--fix'],
        \ 'replace': 1
        \ }
endfunction
