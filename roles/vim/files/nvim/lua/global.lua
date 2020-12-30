local api = vim.api

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
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
