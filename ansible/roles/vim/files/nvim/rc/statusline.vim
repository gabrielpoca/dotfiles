set laststatus=2
set statusline=
set statusline+=\  " Empty space
set statusline+=%< " Where to truncate line
set statusline+=%f " Path to the file in the buffer, as typed or relative to current directory
set statusline+=%{&modified?'\ +':''}
set statusline+=%{&readonly?'\ ':''}
set statusline+=%= " Separation point between left and right aligned items
set statusline+=\ %{coc#status()} " Show errors and warnings from coc.nvim
set statusline+=\ %3p%% " Percentage through file in lines as in |CTRL-G|
set statusline+=\  " Empty space
