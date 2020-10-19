local api = vim.api

local Colors = {}

Colors.setup = function(colorscheme)
  if colorscheme == 'embark' then
    api.nvim_command('let g:embark_terminal_italics=1')

    api.nvim_command('colorscheme ' .. colorscheme)
    api.nvim_command('highlight SignColumn guibg=Normal')
    api.nvim_command('highlight MyPurple guifg=#F48FB1 guibg=#F48FB1')
    api.nvim_command('highlight MyYellow guifg=#FFE6B3 guibg=#FFE6B3')
    api.nvim_command("let g:terminal_color_0 = \'#1e1c31\'")

    api.nvim_set_var('fzf_colors', {
      fg =      {'fg', 'Normal'},
      bg =      {'bg', 'Normal'},
      hl =      {'fg', 'MyPurple'},
      ['fg+'] = {'fg', 'MyYellow'},
      ['bg+'] = {'bg', 'Normal'},
      ['hl+'] = {'fg', 'MyPurple'},
      info =    {'fg', 'PreProc'},
      border =  {'fg', 'StatusLine'},
      prompt =  {'fg', 'Conditional'},
      pointer = {'fg', 'Exception'},
      marker =  {'fg', 'Keyword'},
      spinner = {'fg', 'Label'},
      header =  {'fg', 'Comment'}
    })
  end

  if colorscheme == 'gruvbox' then
    api.nvim_command('let g:gruvbox_contrast_dark=\'hard\'')
    api.nvim_command('let g:gruvbox_italic=1')

    api.nvim_command('colorscheme ' .. colorscheme)
    api.nvim_command('highlight SignColumn guibg=Normal')

    api.nvim_set_var('fzf_colors', {
      fg =      {'fg', 'GruvboxFg3'},
      bg =      {'bg', 'Normal'},
      hl =      {'fg', 'MyPurple'},
      ['fg+'] = {'fg', 'Normal'},
      ['bg+'] = {'bg', 'Normal'},
      ['hl+'] = {'fg', 'Normal'},
      info =    {'fg', 'GruvboxFg4'},
      border =  {'fg', 'StatusLine'},
      prompt =  {'fg', 'GruvboxGreen'},
      pointer = {'fg', 'GruvboxGreen'},
      marker =  {'fg', 'GruvboxYellow'},
      spinner = {'fg', 'Label'},
      header =  {'fg', 'Comment'}
    })
  end

  if colorscheme == 'nord' then
    api.nvim_command('colorscheme ' .. colorscheme)
    api.nvim_command('highlight MyYellow guifg=#D08770 guibg=#D08770')
    api.nvim_command('highlight MyTerm guibg=#3B4252')
    api.nvim_command('highlight MyPurple guifg=#B48EAD guibg=#B48EAD')

    api.nvim_set_var('fzf_colors', {
      fg =      {'fg', 'Normal'},
      bg =      {'bg', 'MyTerm'},
      hl =      {'fg', 'MyPurple'},
      ['fg+'] = {'fg', 'MyYellow'},
      ['bg+'] = {'bg', 'MyTerm'},
      ['hl+'] = {'fg', 'MyPurple'},
      info =    {'fg', 'PreProc'},
      border =  {'fg', 'StatusLine'},
      prompt =  {'fg', 'Conditional'},
      pointer = {'fg', 'Exception'},
      marker =  {'fg', 'Keyword'},
      spinner = {'fg', 'Label'},
      header =  {'fg', 'Comment'}
    })
  end
end

return Colors
