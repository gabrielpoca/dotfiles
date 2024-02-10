return {
  { "AndrewRadev/splitjoin.vim", lazy = false },
  { "gcmt/wildfire.vim",         lazy = false },
  { "tpope/vim-abolish",         lazy = false },
  { "tpope/vim-commentary",      lazy = false },
  { "tpope/vim-surround",        lazy = false },
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>ra", "<cmd>TestSuite<CR>",   desc = "Run test suite" },
      { "<leader>rt", "<cmd>TestFile<CR>",    desc = "Run test file" },
      { "<leader>rr", "<cmd>TestNearest<CR>", desc = "Run test line" },
      { "<leader>rl", "<cmd>TestLast<CR>",    desc = "Run last test" },
    },
  },
  {
    dir = "~/Developer/replacer.nvim",
    keys = {
      {
        "<leader>h",
        function()
          require("replacer").run()
        end,
        desc = "run replacer.nvim",
      },
    },
  },
  {
    "gabrielpoca/term_find.nvim",
    opts = {
      autocmd_pattern = "floaterm",
      keymap_mode = "n",
      keymap_mapping = "gf",
      callback = function()
        vim.cmd("FloatermHide")
      end,
    },
  },
  { "NvChad/nvim-colorizer.lua", lazy = false, config = true },
  {
    "RRethy/vim-illuminate",
    lazy = false,
    config = function()
      require("illuminate").configure({
        filetypes_denylist = { "NvimTree" },
        min_count_to_highlight = 2,
      })
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = "G",
    keys = {
      { "<leader>gb", "<cmd>G blame<CR>",  desc = "Git blame" },
      { "<leader>gp", "<cmd>G push<CR>",   desc = "Git push" },
      { "<leader>go", "<cmd>G browse<CR>", desc = "Git browse" },
      {
        "<leader>gh",
        function()
          require("git").file_history()
        end,
        desc = "Git history for file",
      },
    },
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = true,
    cmd = "Octo",
    keys = { { "<leader>gP", "<cmd>Octo pr list<CR>", desc = "List PRs" } },
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "./snippets" },
      })
    end,
  },
  {
    "folke/which-key.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      local wk = require("which-key")

      wk.register({
        b = { name = "buffer" },
        f = { name = "search" },
        g = { name = "git" },
        l = { name = "language" },
        j = { name = "jump" },
        r = { name = "tests" },
        n = { name = "tree" },
        c = { name = "colorscheme" },
        e = {
          name = "shell",
          s = {
            function()
              require("my.repl").start()
            end,
            "Start server",
          },
          r = {
            function()
              require("my.repl").recompile()
            end,
            "Recompile",
          },
          l = {
            function()
              require("my.repl").send_line()
            end,
            "Send line",
          },
          i = {
            function()
              require("my.repl").install()
            end,
            "Setup projet",
          },
        },
        i = {
          function()
            require("my.terminal").toggle("repl")
          end,
          "General terminal",
        },
        u = {
          function()
            require("my.terminal").toggle("shell")
          end,
          "Tests terminal",
        },
        t = {
          name = "terminal",
          t = {
            function()
              require("my.terminal").open_last()
            end,
            "Open last terminal",
          },
          k = {
            function()
              require("my.terminal").kill()
            end,
            "Kill terminals",
          },
        },
      }, { prefix = "<leader>", nowait = true })
    end,
  },
  { "derekprior/vim-trimmer",    lazy = false },
  {
    "embear/vim-localvimrc",
    lazy = false,
    init = function()
      vim.g.localvimrc_whitelist = { "/Users/gabriel/Developer/.*" }
    end,
    config = function()
      vim.g.localvimrc_sandbox = false
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
      sync_root_with_cwd = true,
      disable_netrw = true,
      git = { ignore = false },
      filters = { custom = { "^\\.DS_Store" } },
      view = {
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 60,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
    },
    keys = {
      {
        "<leader>nn",
        function()
          require("nvim-tree.api").tree.toggle()
        end,
        desc = "Toggle",
      },
      {
        "<leader>nf",
        function()
          require("nvim-tree.api").tree.find_file({
            open = true,
            focus = true,
          })
        end,
        desc = "Find file",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = true },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },
  { "wincent/terminus", lazy = false },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
      options = {
        show_filename_only = false,
        globalstatus = true,
        theme = colorscheme(),
        ignore_focus = { "TelescopePrompt", "NvimTree", "TelescopeResults" },
        disabled_filetypes = { {} },
      },
      sections = {
        lualine_a = { {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
        } },
        lualine_b = {
          "branch",
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "E", warn = "W", info = "I", hint = "H" },
            sections = { "error", "warn", "info", "hint" },
            colored = true,
            update_in_insert = true,
            always_visible = false,
          },
          {
            "diagnostics",
            sources = { "nvim_workspace_diagnostic" },
            symbols = { error = "WE", warn = "WW", info = "WI", hint = "WH" },
            sections = { "error" },
            colored = true,
            update_in_insert = true,
            always_visible = true,
          },
        },
        lualine_c = { { "filename", path = 1 } },
      },
    },
  },
}
