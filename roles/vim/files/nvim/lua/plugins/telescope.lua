return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      layout_config = { height = 0.9, width = 0.9 },
      file_ignore_patterns = {
        "artifacts/",
        "typechain%-types/",
        "node_modules",
        "%.git/",
        "%_build/",
        "%.elixir%_ls",
        "deps",
        "vendor",
        "%.png",
        "%.jpg",
        "%.jpeg",
        "%.gif",
        "%.webp",
        "venv/",
      },
    },
  },
  keys = {
    {
      "<Leader>fw",
      function()
        local telescope = require "telescope.builtin"
        telescope.grep_string { search = "" }
      end,
      desc = "Find words",
    },
  },
}
