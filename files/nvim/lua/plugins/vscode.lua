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
  "hop.nvim",
  "wildfire.nvim",
  "nvim-surround",
  "mini.splitjoin",
})

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return enabled[plugin.name] end

local vscode = require "vscode-neovim"
local previous_jumplist = vim.fn.getjumplist()[1]

local function jump_back() vscode.call "jumplist.jumpBack" end

local function jump_forw() vscode.call "jumplist.jumpForward" end

-- this is not nice, but does the job for now
local function goToDef()
  vscode.call "jumplist.registerJump"
  vscode.call "editor.action.revealDefinition"
end

-- vim.keymap.set({ "n" }, "<c-o>", jump_back, { noremap = true })
-- vim.keymap.set({ "n" }, "<c-i>", jump_forw, { noremap = true })
-- vim.keymap.set({ "n" }, "gd", goToDef, { noremap = true })

local function check_jumplist()
  local current_jumplist = vim.fn.getjumplist()[1]

  if #current_jumplist > #previous_jumplist then vscode.call "jumplist.registerJump" end

  previous_jumplist = current_jumplist
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  callback = check_jumplist,
})

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<c-o>"] = jump_back,
          ["<c-i>"] = jump_forw,
          ["gd"] = goToDef,
          ["<Leader>p"] = "<CMD>call VSCodeNotify('workbench.action.showCommands')<CR>",
          ["<Leader>ld"] = "<CMD>call VSCodeNotify('workbench.actions.view.problems')<CR>",
          ["<Leader>ff"] = "<CMD>Find<CR>",
          ["<Leader>fb"] = "<CMD>call VSCodeNotify('workbench.action.showAllEditors')<CR>",
          ["<Leader>fw"] = "<CMD>call VSCodeNotify('workbench.action.quickTextSearch')<CR>",
          ["<Leader>fp"] = "<CMD>call VSCodeNotify('workbench.action.openRecent')<CR>",
          ["<Leader>ls"] = "<CMD>call VSCodeNotify('workbench.action.gotoSymbol')<CR>",
          ["<Leader>lS"] = "<CMD>call VSCodeNotify('workbench.action.showAllSymbols')<CR>",
          ["<Leader>A"] = "<CMD>call VSCodeNotify('projections.projectAlternateFile')<CR>",
          ["<Leader>V"] = "<CMD>call VSCodeNotify('projections.projectAlternateFileSplit')<CR>",
          ["<Leader>rr"] = '<CMD>call VSCodeNotify("runInTerminal.run", { "name": "l" })<CR>',
          ["<Leader>rt"] = '<CMD>call VSCodeNotify("runInTerminal.run", { "name": "b" })<CR>',
          ["<Leader>ra"] = '<CMD>call VSCodeNotify("runInTerminal.run", { "name": "s" })<CR>',
          ["<Leader>rl"] = '<CMD>call VSCodeNotify("runInTerminal.runLast")<CR>',
          ["<Leader>bc"] = '<CMD>call VSCodeNotify("workbench.action.closeOtherEditors")<CR>',
          ["<Leader>Q"] = '<CMD>call VSCodeNotify("workbench.action.reopenClosedEditor")<CR>',
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
          -- ["s"] = { function() require("hop").hint_words() end },
          -- ["<S-s>"] = { function() require("hop").hint_lines() end },
        },
        v = {
          -- ["s"] = { function() require("hop").hint_words { extend_visual = true } end },
          -- ["<S-s>"] = { function() require("hop").hint_lines { extend_visual = true } end },
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
