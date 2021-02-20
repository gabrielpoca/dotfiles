" exit terminal mode
tnoremap <C-e> <C-\><C-n>

" change settings in terminal
au TermOpen * setlocal nonumber norelativenumber wrap winhl=Normal:MyTerm signcolumn=

" vim-test settings
function! MyStrategy(cmd)
  exec 'lua require"repl".run_test("'.a:cmd.'")'
endfunction

" vim-test config
function! DockerComposeTransform(cmd) abort
  if !exists("g:docker_compose_service")
    echo 'The ' . g:docker_compose_service . ' variable must be set to run this command.'
    return
  endif

  return 'docker-compose exec ' . g:docker_compose_service . ' ' . a:cmd
endfunction

let test#strategy = 'neoterm'
let g:test#custom_transformations = {'docker-compose': function('DockerComposeTransform')}
let g:test#custom_strategies = {'myrepl': function('MyStrategy')}
let g:test#strategy = 'myrepl'
