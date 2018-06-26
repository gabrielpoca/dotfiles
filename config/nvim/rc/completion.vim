" => deoplete
let g:deoplete#enable_at_startup = 1

function Multiple_cursors_before()
  let g:deoplete#disable_auto_complete = 1
endfunction
function Multiple_cursors_after()
  let g:deoplete#disable_auto_complete = 0
endfunction

let g:deoplete#file#enable_buffer_path = 1

" => language client
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
      \ 'javascript': ['/Users/gabriel/.asdf/installs/nodejs/9.3.0/.npm/bin/javascript-typescript-stdio'],
      \ 'javascript.jsx': ['/Users/gabriel/.asdf/installs/nodejs/9.3.0/.npm/bin/javascript-typescript-stdio'],
      \ }

nnoremap <silent> <leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <leader>lr :call LanguageClient_textDocument_rename()<CR>

" => UltiSnipps
let g:UltiSnipsExpandTrigger="<c-o>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:python2_host_prog = '/usr/local/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3'
