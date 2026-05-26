---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    formatting = {
      filter = function(client)
        local biome = require "utils.biome"
        if not biome.applies_to_ft(vim.bo.filetype) then return true end
        local has = biome.has_config()
        if client.name == "biome" then return has end
        return not has
      end,
    },
    servers = {
      "elixirls",
    },
    ---@diagnostic disable: missing-fields
    config = {
      elixirls = {
        cmd = { vim.fn.expand "~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
      },
    },
  },
}
