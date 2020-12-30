function! ToggleCodeLens()
  let l:codelens = CocAction("getConfig", "codeLens")
  let l:toggled = !(l:codelens['enable'])
  call CocAction("updateConfig", "codeLens.enable", l:toggled)
endfunction

nnoremap <silent> <leader>ll :call ToggleCodeLens()<CR>

function! CocStatus()
  return get(g:,'coc_git_status','')
endfunction

set laststatus=2
