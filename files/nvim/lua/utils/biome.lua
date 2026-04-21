local M = {}

local cache = {}

local FT = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  json = true,
  jsonc = true,
  css = true,
}

function M.applies_to_ft(ft) return FT[ft] == true end

function M.has_config(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then return false end
  local dir = vim.fs.dirname(path)
  if cache[dir] ~= nil then return cache[dir] end
  local found = vim.fs.find({ "biome.json", "biome.jsonc" }, {
    upward = true,
    path = dir,
    stop = vim.loop.os_homedir(),
  })
  cache[dir] = #found > 0
  return cache[dir]
end

function M.clear_cache() cache = {} end

return M
