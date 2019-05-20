function! DoTfFMT(buffer) abort
  return { 'command': 'terraform fmt -list=false -' }
endfunction

let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'typescript': [],
      \   'jsx': ['eslint'],
      \   'css': [],
      \   'scss': [],
      \   'elixir': ['credo'],
      \   'ruby': [],
      \   'html': [],
      \   'markdown': [],
      \}

let g:ale_fix_on_save = 1

"let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5 --prose-wrap always'
let g:ale_javascript_prettier_use_local_config = 1

let g:ale_fixers = {
      \   'markdown': ['prettier'],
      \   'javascript': ['prettier'],
      \   'typescript': ['prettier'],
      \   'javascript.jsx': ['prettier'],
      \   'elixir': ['mix_format'],
      \   'css': ['stylelint'],
      \   'scss': ['stylelint'],
      \   'terraform': ['DoTfFMT'],
      \}
