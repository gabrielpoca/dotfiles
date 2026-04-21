return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    local biome = require "utils.biome"
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    for ft, formatters in pairs(opts.formatters_by_ft) do
      if biome.applies_to_ft(ft) and type(formatters) == "table" then
        local prev = vim.deepcopy(formatters)
        opts.formatters_by_ft[ft] = function(bufnr)
          if biome.has_config(bufnr) then return {} end
          return prev
        end
      end
    end
    return opts
  end,
}
