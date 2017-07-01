" ternjs
let g:tern#arguments = ["--persistent"]
let g:tern#command = ["tern"]
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0 " disable full signature type on autocomplete
let tern_is_show_argument_hints_enabled = 1
let tern_map_keys = 1
let tern_show_signature_in_pum = 1

" mxw/vim-jsx
let g:jsx_ext_required = 0

" othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'react,ramda,underscore,jquery,angularjs'

" neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

" prettier
function! neoformat#formatters#javascript#prettier() abort
  return {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin', '--single-quote', '--trailing-comma es5'],
        \ 'stdin': 1,
        \ }
endfunction

" extensions permitted with gf
autocmd FileType javascript set suffixesadd=.js,.json,.html,.jsx

" => Angular experiments
function! AngularDirectiveToTemplate(mod)
ruby << EOF
  @buffer = VIM::Buffer.current

  file = @buffer.lines
    .find { |line| line.include?("templateUrl") }
    .match(/'.*'/)[0]
    .tr("'", "")

  VIM.command(":#{VIM::evaluate('a:mod')} app/assets/templates/#{file.to_s}") if file
EOF
endfunction

autocmd BufRead,BufNewFile *angular/directives/*.js nnoremap <silent> <leader>aa :call AngularDirectiveToTemplate('e')<CR>
autocmd BufRead,BufNewFile *angular/directives/*.js nnoremap <silent> <leader>av :call AngularDirectiveToTemplate('vs')<CR>

function! AngularTemplateToDirective()
ruby << EOF
  @buffer = VIM::Buffer.current

  match = @buffer.line.match(/<\/?([\w\-]+)/)

  return unless match

  directive = match[1].split("-").join("_")
  VIM.command(":e app/assets/javascripts/angular/directives/#{directive}.js")
EOF
endfunction

autocmd BufRead,BufNewFile *assets/templates*.html nnoremap <silent> <C-]> :call AngularTemplateToDirective()<cr>
