floating = require "../floating"

function NavigationFloatingWin()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  floating.new_buffer(buf)
end
