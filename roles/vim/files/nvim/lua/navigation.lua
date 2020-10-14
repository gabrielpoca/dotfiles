local floating = require "./floating"

local function floating_window()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  floating.new_buffer(buf)
end

return {
  floating_window = floating_window
}
