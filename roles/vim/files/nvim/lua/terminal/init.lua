list_of_terms = {}

function to_floating_window(buf)
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

function Terminal(nr, command, ...)
  if command == nil then
    command = "/usr/local/bin/fish"
  end

  if list_of_terms[nr] then
    to_floating_window(list_of_terms[nr])
  else
    list_of_terms[nr] = vim.api.nvim_create_buf(false, false)
    to_floating_window(list_of_terms[nr])
    vim.api.nvim_call_function("termopen", {command})
    vim.api.nvim_command(":au WinLeave <buffer> :close")
  end

  vim.api.nvim_command(":startinsert")
end

tig_current_nr = 100

function TerminalTig()
  TerminalTigOpen("tig")
end

function TerminalTigCurrentFile()
  TerminalTigOpen("tig " .. vim.api.nvim_call_function("expand", {"%:p"}))
end

function TerminalTigOpen(command)
  Terminal(tig_current_nr, command)
  tig_current_nr = tig_current_nr + 1
end
