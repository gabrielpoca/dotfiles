nmap <leader>et 0cwimportjkf=dt(lds(ifrom jkj0

" URL encode a string. ie. Percent-encode characters as necessary.
function! UrlEncode(string)
  let result = ""

  let characters = split(a:string, '.\zs')
  for character in characters
    if character == " "
      let result = result . "+"
    elseif CharacterRequiresUrlEncoding(character)
      let i = 0
      while i < strlen(character)
        let byte = strpart(character, i, 1)
        let decimal = char2nr(byte)
        let result = result . "%" . printf("%02x", decimal)
        let i += 1
      endwhile
    else
      let result = result . character
    endif
  endfor

  return result
endfunction

" Returns 1 if the given character should be percent-encoded in a URL encoded
" string.
function! CharacterRequiresUrlEncoding(character)
  let ascii_code = char2nr(a:character)
  if ascii_code >= 48 && ascii_code <= 57
    return 0
  elseif ascii_code >= 65 && ascii_code <= 90
    return 0
  elseif ascii_code >= 97 && ascii_code <= 122
    return 0
  elseif a:character == "-" || a:character == "_" || a:character == "." || a:character == "~"
    return 0
  endif
  return 1
endfunction

function! GetVisualSelection ()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

function! TranslateSelection ()
  let text = UrlEncode(GetVisualSelection())
  let url = "https://translate.google.com/#view=home&op=translate&sl=en&tl=pt&text=".text
  exec "!open ".shellescape(url, 1)
endfunction

vmap <silent> <leader>m :call TranslateSelection()<CR>

"move lines around
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

"replace the word under cursor
nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>

" Makes s (along with corresponding maps for ss and S) act like d, except it
" doesn’t save the cut text to a register. Helps when I want to delete
" something without clobbering my unnamed register.
nnoremap s "_d
nnoremap s "_dd
nnoremap S "_D
