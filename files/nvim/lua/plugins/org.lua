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
    win_split_mode = "tabnew",
    org_agenda_files = "~/work_org/**/*",
    org_startup_indented = true,
    org_default_notes_file = "~/work_org/refile.org",
    org_startup_folded = "content",
    org_todo_keywords = { "TODO", "|", "DONE", "|", "KILL" },

    mappings = {
      prefix = "<Leader>n",
    },

    org_capture_templates = {
      t = {
        description = "Task",
        template = "* TODO %?\nDEADLINE: %t",
        target = "~/work_org/tasks.org",
      },
      l = {
        description = "Someday/Maybe",
        template = "* %? :someday:\n%u",
        target = "~/work_org/later.org",
      },
      j = {
        description = "Journal",
        template = "* %<%y%m%d> %?",
        target = "~/work_org/journal.org",
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
    org_agenda_custom_commands = {
      u = {
        description = "TODO tasks with no deadline",
        types = {
          {
            type = "tags_todo",
            org_agenda_overriding_header = '"TODO tasks with no deadline"',
            org_agenda_todo_ignore_scheduled = "all",
            org_agenda_todo_ignore_deadlines = "all",
          },
        },
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
      function() require("snacks").picker.files { cwd = "~/work_org" } end,
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
          {
            org = { "buffer", "path", "orgmode", "snippets" },
          },
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

    local work_org_path = vim.fn.expand "~/work_org"
    local watcher_started = false
    local debounce_timers = {}

    local function auto_commit_file(filename)
      if not filename:match "%.org$" then return end

      if debounce_timers[filename] then vim.loop.timer_stop(debounce_timers[filename]) end

      debounce_timers[filename] = vim.loop.new_timer()
      debounce_timers[filename]:start(
        1000,
        0,
        vim.schedule_wrap(function()
          vim.notify("Committing " .. filename, vim.log.levels.INFO)
          vim.fn.jobstart({
            "sh",
            "-c",
            string.format(
              'cd ~/work_org && git add "%s" && (git diff --cached --quiet "%s" || (git commit -m "Update %s" && git push))',
              filename,
              filename,
              filename
            ),
          })
        end)
      )
    end

    local function start_watcher()
      if watcher_started then return end

      vim.notify("Starting org file watcher for " .. work_org_path, vim.log.levels.INFO)
      local handle = vim.loop.new_fs_event()
      handle:start(work_org_path, { recursive = true }, function(err, filename, events)
        if err then
          vim.notify("File watcher error: " .. err, vim.log.levels.ERROR)
          return
        end
        if filename and events.change then vim.schedule(function() auto_commit_file(filename) end) end
      end)
      watcher_started = true
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = start_watcher,
      once = true,
    })
  end,
}
