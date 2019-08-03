let g:ale_completion_enabled = 0
let g:ale_set_highlights = 0

" LINTER

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

" FIXER

let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1

function! DoTfFMT(buffer) abort
  return { 'command': 'terraform fmt -list=false -' }
endfunction

let g:ale_fixers = {
      \   'markdown': ['prettier'],
      \   'javascript': ['prettier'],
      \   'typescript': ['prettier'],
      \   'javascript.jsx': ['prettier'],
      \   'elixir': ['mix_format'],
      \   'css': [],
      \   'scss': [],
      \   'terraform': ['DoTfFMT'],
      \}

