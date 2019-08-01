let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:NERDTreeWinPos = "left"
let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = "%{''}"

nnoremap <silent> <leader>nn :NERDTreeToggle<cr>
nnoremap <silent> <leader>nf :NERDTreeFind<cr>

au FileType nerdtree set nocursorline
au FileType nerdtree set nocursorcolumn
