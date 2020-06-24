local Colors = {}

Colors.setup = function(colorscheme)
  vim.api.nvim_command('colorscheme ' .. colorscheme)

  if colorscheme == 'nord' then
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
