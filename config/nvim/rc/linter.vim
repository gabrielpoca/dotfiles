let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'jsx': ['eslint'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'elixir': ['credo'],
\   'ruby': ['rubocop'],
\   'html': [],
\   'markdown': [],
\}

let g:ale_fix_on_save = 1

let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5 --prose-wrap always'

let g:ale_fixers = {
\   'markdown': ['prettier'],
\   'javascript': ['prettier'],
\   'javascript.jsx': ['prettier'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\}
