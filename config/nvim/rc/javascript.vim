let g:neoformat_javascript_prettier = {
      \ 'exe': 'prettier',
      \ 'args': ['--stdin', '--single-quote', '--no-semi'],
      \ 'stdin': 1,
      \ }

" mxw/vim-jsx
let g:jsx_ext_required = 0

" othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'react,ramda,underscore,jquery,angularjs'

" extensions permitted with gf
autocmd FileType javascript set suffixesadd=.js,.json,.html,.jsx,.tsx,.ts

" => angular experiments
function! AngularDirectiveToTemplate(mod)
ruby << EOF
  lambda do
    buffer = VIM::Buffer.current

    file = buffer.lines
      .find { |line| line.include?("templateUrl") }
      .match(/'.*'/)[0]
      .tr("'", "")

    VIM.command(":#{VIM::evaluate('a:mod')} app/assets/templates/#{file.to_s}") if file
  end.()
EOF
endfunction

autocmd BufRead,BufNewFile *angular/directives/*.js nnoremap <silent> <leader>aa :call AngularDirectiveToTemplate('e')<CR>
autocmd BufRead,BufNewFile *angular/directives/*.js nnoremap <silent> <leader>av :call AngularDirectiveToTemplate('vs')<CR>

function! AngularTemplateToDirectiveOrCSS()
ruby << EOF
  lambda do
    buffer = VIM::Buffer.current

    if buffer.line.include?("class=")
      match = buffer.line.match(/class="([\w-]+)"/)

      if match
        file = match[1].split("__")[0].split("--")[0].gsub("-", "_")
        VIM.command(":e app/assets/stylesheets/application_nsx/components/#{file}.scss")
      end
    else
      match = buffer.line.match(/<\/?([\w\-]+)/)

      if match
        directive = match[1].gsub("-", "_")
        VIM.command(":e app/assets/javascripts/angular/directives/#{directive}.js")
      end
    end
  end.()
EOF
endfunction

autocmd BufRead,BufNewFile *assets/templates*.html nnoremap <silent> <C-]> :call AngularTemplateToDirectiveOrCSS()<cr>
