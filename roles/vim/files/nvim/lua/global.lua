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

function _G.table_size (t)
  local max = 0

  for i, _ in pairs(t) do
    if i > max then
      max = i
    end
  end

  return max
end

function _G.basename(path)
  chunks = vim.fn.split(path, "/")
  size = table_size(chunks)

  if size == 1 then
    return nil
  end

  return vim.fn.join(vim.fn.remove(chunks, 0, -2), "/")
end

function _G.filter_array(a, filter_iter)
  local out = {}

  for k, v in pairs(a) do
    if filter_iter(v, k, a) then table.insert(out, v) end
  end

  return out
end

table.filter = function(t, filter_iter)
  local out = {}

  for k, v in pairs(t) do
    if filter_iter(v, k, t) then out[k] = v end
  end

  return out
end

table.map = function(t, filter_iter)
  local out = {}

  for k, v in pairs(t) do
    out[k] = filter_iter(v, k, t)
  end

  return out
end
