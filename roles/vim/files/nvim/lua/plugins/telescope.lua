return {
  { "smartpde/telescope-recent-files" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>o",
        function()
          local telescope = require("telescope.builtin")
          telescope.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>p",
        function()
          local telescope = require("telescope.builtin")

          telescope.find_files({ hidden = true })
        end,
        desc = "Files",
      },
      {
        "<leader>P",
        function()
          local telescope = require("telescope")

          telescope.extensions.recent_files.pick()
        end,
        desc = "Recent files",
      },
      {
        "<leader>fw",
        function()
          local telescope = require("telescope.builtin")
          telescope.grep_string()
        end,
        desc = "Search for word under cursor",
      },
      {
        "<leader>fv",
        function()
          local telescope = require("telescope.builtin")
          telescope.grep_string()
        end,
        mode = "v",
        desc = "Search for selection",
      },
      {
        "<leader>ff",
        function()
          local telescope = require("telescope.builtin")
          telescope.grep_string({ search = "" })
        end,
        desc = "Search for input",
      },
      {
        "<leader>fg",
        function()
          local telescope = require("telescope.builtin")
          telescope.git_status()
        end,
        desc = "Find changed files",
      },
    },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          layout_strategy = "flex",
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
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
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
        },
        extensions = {
          recent_files = {
            stat_files = true,
            only_cwd = true,
          },
        },
        pickers = {
          grep_string = {
            prompt_prefix = " 🔍 ",
            previewer = false,
          },
        },
      })

      require("telescope").load_extension("recent_files")
    end,
  },
}
