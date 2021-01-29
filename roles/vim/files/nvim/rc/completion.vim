" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number

" Hard-coded path to node
let g:coc_node_path = '/Users/gabrielpoca/.asdf/shims/node' 

" Use <cr> or <tab> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <tab> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<tab>"
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<cr>"
else
  inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<tab>"
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>"
endif

" close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" navigate diagnostics
nnoremap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>ln <Plug>(coc-diagnostic-next)
" show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" show all diagnostics
nnoremap <silent> <leader>ld  :<C-u>CocList diagnostics<cr>
" manage extensions
nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
" show commands
nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
" find symbol of current document
nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
