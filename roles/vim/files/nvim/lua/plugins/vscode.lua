if not vim.g.vscode then return {} end

local enabled = {}
vim.tbl_map(function(plugin) enabled[plugin] = true end, {
  -- core plugins
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
  -- more known working
  "dial.nvim",
  "flash.nvim",
  "flit.nvim",
  "leap.nvim",
  "mini.ai",
  "mini.comment",
  "mini.move",
  "mini.pairs",
  "mini.surround",
  "ts-comments.nvim",
  "vim-easy-align",
  "vim-repeat",
  "vim-sandwich",
  "yanky.nvim",
  -- feel free to open PRs to add more support!
  "tpope/vim-projectionist",
})

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return enabled[plugin.name] end

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
          ["<Leader>fp"] = "<CMD>call VSCodeNotify('workbench.action.openRecent')<CR>",
          ["<Leader>ls"] = "<CMD>call VSCodeNotify('workbench.action.gotoSymbol')<CR>",
          ["<Leader>A"] = "<CMD>call VSCodeNotify('projections.projectAlternateFile')<CR>",
          ["<Leader>V"] = "<CMD>call VSCodeNotify('projections.projectAlternateFileSplit')<CR>",
          ["<Leader>rr"] = '<CMD>call VSCodeNotify("runInTerminal.run", { "name": "l" })<CR>',
          ["<Leader>rt"] = '<CMD>call VSCodeNotify("runInTerminal.run", { "name": "b" })<CR>',
          ["<Leader>ra"] = '<CMD>call VSCodeNotify("runInTerminal.run", { "name": "s" })<CR>',
          ["<Leader>rl"] = '<CMD>call VSCodeNotify("runInTerminal.runLast")<CR>',
          ["za"] = '<CMD>call VSCodeNotify("editor.toggleFold")<CR>',
          ["<leader><leader>a"] = "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>",
          ["<leader><leader>e"] = "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>",
          ["<leader><leader>f"] = "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>",
          ["<leader><leader>1"] = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>",
          ["<leader><leader>2"] = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>",
          ["<leader><leader>3"] = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>",
          ["<leader><leader>4"] = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>",
          ["<leader><leader>5"] = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>",
          ["<leader><leader>6"] = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>",
          ["<leader><leader>7"] = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>",
          ["<leader><leader>8"] = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>",
          ["<leader><leader>9"] = "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>",
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
