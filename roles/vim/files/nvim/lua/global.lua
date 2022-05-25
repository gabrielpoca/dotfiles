local api = vim.api

function _G.dump(...)
  vim.pretty_print(...)
end

function _G.set_keymaps(mappings, mode)
  local mode = mode or 'n'

  for k,v in pairs(mappings) do
    api.nvim_set_keymap(mode, k, ':'..v..'<cr>', { nowait = true, noremap = true, silent = true })
  end
end

function _G.reload_current_file()
  vim.cmd(":luafile %")
end

function _G.basename(path)
  chunks = vim.fn.split(path, "/")
  size = vim.tbl_count(chunks)

  if size == 1 then
    return nil
  end

  return vim.fn.join(vim.fn.remove(chunks, 0, -2), "/")
end


function _G.set_keymap(mode, lhs, rhs, opts)
  local options = {noremap = true}

  if opts then options = vim.tbl_extend('force', options, opts) end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

