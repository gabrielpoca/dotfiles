function new_buffer(buf)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local win_height = math.ceil(height * 4 / 5)
  local win_width

  if (width < 150) then
    win_width = math.ceil(width - 8)
  else
    win_width = math.ceil(width * 0.9)
  end

  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = math.ceil((height - win_height) / 2),
    col = math.ceil((width - win_width) / 2)
  }

  local win = vim.api.nvim_open_win(buf, true, opts)
end

return {
  new_buffer = new_buffer
}
