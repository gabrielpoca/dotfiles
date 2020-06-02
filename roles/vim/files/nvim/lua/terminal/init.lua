list_of_terms = {}

floating = require "../floating"

function Terminal(nr, command, ...)
  if command == nil then
    command = "/usr/local/bin/fish"
  end

  if list_of_terms[nr] then
    floating.new_buffer(list_of_terms[nr])
  else
    list_of_terms[nr] = vim.api.nvim_create_buf(false, false)
    floating.new_buffer(list_of_terms[nr])
    vim.api.nvim_call_function("termopen", {command})
    vim.api.nvim_command(":au WinLeave <buffer> :close")
  end

  vim.api.nvim_command(":startinsert")
end

tig_current_nr = 100

function TerminalTig()
  TerminalTigOpen("tig status")
end

function TerminalTigCurrentFile()
  TerminalTigOpen("tig " .. vim.api.nvim_call_function("expand", {"%:p"}))
end

function TerminalTigOpen(command)
  Terminal(tig_current_nr, command)
  tig_current_nr = tig_current_nr + 1
end
