function NavigationFloatingWin()
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  -- if the editor's window is big enough
  if (width > 150 or height > 35) then
    local win_height = math.min(math.ceil(height * 3 / 4), 30)
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
end
