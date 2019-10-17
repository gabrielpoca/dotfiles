" DEOPLETE
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option('sources', {
\ 'typescript': ['ale'],
\ 'javascript': ['ale'],
\ 'elixir': ['ale'],
\})

" ALE
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_elixir_elixir_ls_release = '~/.elixir_ls'
let g:ale_linters = {
      \   'javascript': ['tsserver', 'eslint'],
      \   'typescript': ['tsserver', 'eslint'],
      \   'css': [],
      \   'scss': [],
      \   'elixir': ['mix', 'credo'],
      \   'ruby': [],
      \   'html': [],
      \   'markdown': [],
      \}

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

let g:vista_default_executive = 'ale'
