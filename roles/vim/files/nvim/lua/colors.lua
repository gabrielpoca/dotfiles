require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  },
  indent = {
    enable = false
  }
}

local api = vim.api

local Colors = {}

Colors.setup = function(colorscheme)
  vim.o.termguicolors = true
  vim.o.background = "dark"

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
  elseif colorscheme == "dracula" then
    api.nvim_command('colorscheme ' .. colorscheme)

    api.nvim_set_var('fzf_colors', {
      fg =      {'fg', 'DraculaFg'},
      bg =      {'bg', 'Normal'},
      hl =      {'fg', 'DraculaCyan'},
      ['fg+'] = {'fg', 'Normal'},
      ['bg+'] = {'bg', 'Normal'},
      ['hl+'] = {'fg', 'Normal'},
      --info =    {'fg', 'DraculaBgLight'},
      border =  {'fg', 'StatusLine'},
      prompt =  {'fg', 'draculacomment'},
      pointer = {'fg', 'DraculaCyan'},
      marker =  {'fg', 'DraculaYellow'},
      spinner = {'fg', 'Label'},
      header =  {'fg', 'Comment'}
    })
  end
end

return Colors

