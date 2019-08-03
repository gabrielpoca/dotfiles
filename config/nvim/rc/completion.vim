" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show signcolumns
set signcolumn=yes

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" To make snippet completion work just like VSCode, add:
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Navigate diagnostics
nnoremap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>ln <Plug>(coc-diagnostic-next)
" Show documentation in preview window
nnoremap <silent> <leader>dw :call <SID>show_documentation()<CR>
" Rename current word
nnoremap <silent> <leader>lr <Plug>(coc-rename)
" Fix autofix problem of current line
nnoremap <silent> <leader>lf  <Plug>(coc-fix-current)
" Show all diagnostics
nnoremap <silent> <leader>ld  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
" Resume latest coc list
nnoremap <silent> <leader>lp  :<C-u>CocListResume<CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile
