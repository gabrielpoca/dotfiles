local api = vim.api

local Colors = {}

Colors.setup = function(colorscheme)
  if colorscheme == 'gruvbox' then
    vim.g.gruvbox_contrast_dark= "hard"
    vim.g.gruvbox_italic = 1

    vim.cmd[[augroup MyColors]]
      vim.cmd[[autocmd!]]
      vim.cmd[[autocmd ColorScheme * hi FloatermBorder guibg=Normal guifg=#928374]]
      vim.cmd[[autocmd ColorScheme * hi Floaterm guibg=Normal]]
      vim.cmd[[autocmd ColorScheme * hi CocExplorerNormalFloatBorder guifg=#414347 guibg=Normal]]
      vim.cmd[[autocmd ColorScheme * hi CocExplorerNormalFloat guibg=Normal]]
      vim.cmd[[autocmd ColorScheme * hi SignColumn guibg=Normal]]
      vim.cmd[[autocmd ColorScheme * hi Pmenu guibg=Normal]]
    vim.cmd[[augroup END]]

    api.nvim_command('colorscheme ' .. colorscheme)

    api.nvim_set_var('lightline', {
      colorscheme = 'gruvbox',
      active = {
        left = {
          {'mode', 'paste'},
          {'readonly', 'relativepath', 'modified'}
        },
        right = {{'lineinfo' }, {'filetype'} , {'gitbranch'}}
      },
      component = {
        relativepath = '%f'
      },
      component_function = {
        gitbranch = 'FugitiveHead'
      }
    })

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
