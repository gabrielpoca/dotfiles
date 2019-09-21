" uou will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

let g:coc_node_path = '/Users/gabrielpoca/.asdf/shims/node' 

" use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" coc only does snippet and additional edit on confirm.
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" to make snippet completion work just like VSCode, add:
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" navigate diagnostics
nnoremap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" show documentation in preview window
nnoremap <silent> <leader>dw :call <SID>show_documentation()<CR>

" show all diagnostics
nnoremap <silent> <leader>ld  :<C-u>CocList diagnostics<cr>

" manage extensions
nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>

" show commands
nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>

" find symbol of current document
nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>

" vista.vim disable icons
let g:vista#renderer#enable_icon = 0

" vista.vim use coc.nvim
let g:vista_default_executive = 'coc'
