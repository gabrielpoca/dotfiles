local api = vim.api

local Colors = {}

Colors.setup = function(colorscheme)
  if colorscheme == 'gruvbox' then
    api.nvim_command('let g:gruvbox_contrast_dark=\'hard\'')
    api.nvim_command('let g:gruvbox_italic=1')
    api.nvim_command('colorscheme ' .. colorscheme)
    api.nvim_command('highlight SignColumn guibg=Normal')
    api.nvim_set_var('lightline', { colorscheme = 'gruvbox'})

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
end

return Colors
