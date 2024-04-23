local api = vim.api
local fn = vim.fn

function _G.executable(e)
  return fn.executable(e) > 0
end

function _G.startinsert()
  vim.schedule(function()
    vim.cmd("startinsert")
  end)
end

function _G.colorscheme()
  return os.getenv("COLORSCHEME")
end

function _G.colorscheme_variant()
  return os.getenv("COLORSCHEME_VARIANT")
end

function _G.includes(filename, contents, on_done)
  vim.fn.jobstart("grep " .. contents .. " " .. filename, {
    on_stdout = function(_, data, _)
      on_done(vim.tbl_count(data) > 1)
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

function _G.empty(thing)
  return vim.fn.empty(thing) == 1
end

function _G.dump(...)
  vim.print(...)
end

function _G.set_keymaps(mappings, mode)
  local mode = mode or "n"

  for k, v in pairs(mappings) do
    api.nvim_set_keymap(mode, k, ":" .. v .. "<cr>", { nowait = true, noremap = true, silent = true })
  end
end

function _G.reload_current_file()
  vim.cmd(":luafile %")
end

function _G.basename(path)
  local chunks = vim.fn.split(path, "/")
  local size = vim.tbl_count(chunks)

  if size == 1 then
    return nil
  end

  ---@diagnostic disable-next-line: redundant-parameter,param-type-mismatch
  return vim.fn.join(vim.fn.remove(chunks, 0, -2), "/")
end

function _G.set_keymap(mode, lhs, rhs, opts)
  local options = { noremap = true }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function _G.merge(t1, t2)
  for k, v in pairs(t2) do
    if (type(v) == "table") and (type(t1[k] or false) == "table") then
      merge(t1[k], t2[k])
    else
      t1[k] = v
    end
  end

  return t1
end
