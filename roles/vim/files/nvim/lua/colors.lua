local Colors = {}

Colors.setup = function(colorscheme)
  if colorscheme == 'gruvbox' then
    vim.api.nvim_command('let g:gruvbox_contrast_dark=\'hard\'')
    vim.api.nvim_command('let g:gruvbox_italic=1')

    vim.api.nvim_command('colorscheme ' .. colorscheme)

    vim.api.nvim_command('highlight SignColumn guibg=Normal')

    local fzf_colors = {
      fg =      {'fg', 'GruvboxFg3'},
      bg =      {'bg', 'Normal'},
      hl =      {'fg', 'GruvboxFg0'},
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
    }

    vim.api.nvim_set_var('fzf_colors', fzf_colors)
  end

  if colorscheme == 'nord' then
    vim.api.nvim_command('colorscheme ' .. colorscheme)

    vim.api.nvim_command('highlight MyYellow guifg=#D08770 guibg=#D08770')
    vim.api.nvim_command('highlight MyTerm guibg=#3B4252')
    vim.api.nvim_command('highlight MyPurple guifg=#B48EAD guibg=#B48EAD')

    local fzf_colors = {
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
    }

    vim.api.nvim_set_var('fzf_colors', fzf_colors)
  end
end

return Colors
