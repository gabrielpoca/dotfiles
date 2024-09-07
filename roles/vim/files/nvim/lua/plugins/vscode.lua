if not vim.g.vscode then return {} end

-- a list of known working plugins with vscode-neovim, update with your own plugins
local plugins = {
  "lazy.nvim",
  "AstroNvim",
  "astrocore",
  "astroui",
  "Comment.nvim",
  "nvim-autopairs",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
}

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return vim.tbl_contains(plugins, plugin.name) end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>ff"] = "<CMD>Find<CR>",
          ["<Leader>fw"] = "<CMD>call VSCodeNotify('workbench.action.findInFiles')<CR>",
          ["<Leader>ls"] = "<CMD>call VSCodeNotify('workbench.action.gotoSymbol')<CR>",
          ["<Leader>a"] = "<CMD>call VSCodeNotify('projections.projectAlternateFile')<CR>",
          ["<Leader>v"] = "<CMD>call VSCodeNotify('projections.projectAlternateFileSplit')<CR>",
          ["<Leader>rr"] = '<CMD>call VSCodeNotify("runInTerminal.run", { "name": "l" })<CR>',
          ["<Leader>rt"] = '<CMD>call VSCodeNotify("runInTerminal.run", { "name": "b" })<CR>',
          ["<Leader>ra"] = '<CMD>call VSCodeNotify("runInTerminal.run", { "name": "s" })<CR>',
          ["<Leader>rl"] = '<CMD>call VSCodeNotify("runInTerminal.run")<CR>',
          ["za"] = '<CMD>call VSCodeNotify("editor.toggleFold")<CR>',
        },
      },
    },
  },
  -- disable colorscheme setting
  { "AstroNvim/astroui", opts = { colorscheme = false } },
  -- disable treesitter highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
