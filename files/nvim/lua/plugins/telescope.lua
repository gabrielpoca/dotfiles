local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local mm = { -- my mappings
  ["<CR>"] = function(pb)
    local picker = action_state.get_current_picker(pb)
    local multi = picker:get_multi_selection()
    actions.select_default(pb) -- the normal enter behaviour
    for _, j in pairs(multi) do
      if j.path ~= nil then -- is it a file -> open it as well:
        vim.cmd(string.format("%s %s", "edit", j.path))
      end
    end
  end,
}

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<c-d>"] = actions.delete_buffer,
        },
        n = { ["<C-c>"] = actions.close },
      },
      layout_config = { height = 0.9, width = 0.9 },
      file_ignore_patterns = {
        "out/",
        "abis/",
        "abi/",
        "cache/",
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
      "<C-f>",
      function() require("telescope.builtin").find_files() end,
      desc = "Find files",
    },
    {
      "<Leader>fw",
      function()
        local telescope = require "telescope.builtin"
        telescope.grep_string { search = "" }
      end,
      desc = "Find words in all files",
    },
  },
}
