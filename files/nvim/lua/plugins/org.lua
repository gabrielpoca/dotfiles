return {
  "nvim-orgmode/orgmode",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-orgmode/telescope-orgmode.nvim",
    "nvim-orgmode/org-bullets.nvim",
    "Saghen/blink.cmp",
  },
  event = "VeryLazy",
  opts = {
    win_split_mode = { "float", 0.6 },
    org_agenda_files = "~/Obsidian/Work/org/**/*",
    org_startup_indented = true,
    org_default_notes_file = "~/Obsidian/Work/org/refile.org",
    org_startup_folded = "content",

    mappings = {
      prefix = "<Leader>n",
    },

    org_capture_templates = {
      t = {
        description = "Task",
        template = "* TODO %?",
        target = "~/Obsidian/Work/org/tasks.org",
      },
      l = {
        description = "Someday/Maybe",
        template = "* %? :someday:\n%u",
        target = "~/Obsidian/Work/org/later.org",
      },
      j = {
        description = "Journal",
        template = "* %<%y%m%d>: %?\n%U",
        target = "~/Obsidian/Work/org/journal.org",
      },
    },

    org_agenda_span = "day",
    org_agenda_start_on_weekday = 1,

    org_agenda_templates = {
      d = {
        description = "Daily Agenda",
        agenda_filter = "+SCHEDULED=<today>|+DEADLINE=<today>",
      },
    },
  },
  keys = {
    { "<leader>n", "", desc = "Org Mode" },
    { "<leader>nid", "", desc = "Change deadline" },
    { "<leader>nr", "", desc = "Refile" },
    { "<leader>n*", "", desc = "Toggle headline" },
    { "<leader>na", function() require("orgmode").action "agenda.prompt" end, desc = "Agenda" },
    { "<leader>nc", function() require("orgmode").action "capture.prompt" end, desc = "Capture" },
    {
      "<leader>nr",
      function() require("telescope").extensions.orgmode.refile_heading() end,
      desc = "Refile heading",
    },
    {
      "<leader>nh",
      function() require("telescope").extensions.orgmode.search_headings() end,
      desc = "Searching headings",
    },
    {
      "<leader>ni",
      function() require("telescope").extensions.orgmode.insert_link() end,
      desc = "Insert link",
    },
    {
      "<leader>nf",
      function() require("snacks").picker.files { cwd = "~/Obsidian/Work/org" } end,
      desc = "Find",
    },
  },
  config = function(_, opts)
    local org = require "orgmode"

    org.setup(opts)

    require("org-bullets").setup()

    require("blink.cmp").setup {
      sources = {
        per_filetype = {
          { org = { "buffer", "path", "orgmode", "snippets" } },
        },
        providers = {
          orgmode = {
            name = "Orgmode",
            module = "orgmode.org.autocompletion.blink",
            fallbacks = { "buffer" },
          },
        },
      },
    }

    require("telescope").setup()
    require("telescope").load_extension "orgmode"

    vim.keymap.set("n", "<leader>nr", require("telescope").extensions.orgmode.refile_heading)
    vim.keymap.set("n", "<leader>nh", require("telescope").extensions.orgmode.search_headings)
    vim.keymap.set("n", "<leader>ni", require("telescope").extensions.orgmode.insert_link)
  end,
}
