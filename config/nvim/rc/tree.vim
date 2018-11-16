let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:NERDTreeWinPos = "right"
let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = "%{''}"

nnoremap <silent> <leader>nn :NERDTreeToggle<cr>
nnoremap <silent> <leader>nf :NERDTreeFind<cr>

"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
"endfunction

"call NERDTreeHighlightFile('jade', 'green', 'none', 'green', 'none')
"call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', 'none')
"call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', 'none')
"call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', 'none')
"call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', 'none')
"call NERDTreeHighlightFile('jsx', 'Red', 'none', '#ffa500', 'none')
"call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', 'none')
"call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', 'none')

au FileType nerdtree set nocursorline
au FileType nerdtree set nocursorcolumn
