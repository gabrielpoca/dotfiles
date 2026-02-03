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
    org_default_notes_file = "~/work_org/main.org",
    org_startup_folded = "showeverything",
    org_todo_keywords = { "TODO", "|", "DONE", "|", "KILL" },

    mappings = {
      prefix = "<Leader>n",
      org = {
        org_refile = false,
      },
    },

    org_capture_templates = {
      t = {
        description = "Task",
        template = "** TODO %?\nDEADLINE: %t",
        target = "~/work_org/main.org",
        datetree = {
          tree_type = "custom",
          tree = {
            { format = "%y%m%d", pattern = "^(%d%d)(%d%d)(%d%d)$", order = { 1, 2, 3 } },
          },
        },
      },
      l = {
        description = "Someday/Maybe",
        template = "** %? :someday:",
        target = "~/work_org/main.org",
        datetree = {
          tree_type = "custom",
          tree = {
            { format = "%y%m%d", pattern = "^(%d%d)(%d%d)(%d%d)$", order = { 1, 2, 3 } },
          },
        },
      },
      j = {
        description = "Journal",
        template = "** %?",
        target = "~/work_org/main.org",
        datetree = {
          tree_type = "custom",
          tree = {
            { format = "%y%m%d", pattern = "^(%d%d)(%d%d)(%d%d)$", order = { 1, 2, 3 } },
          },
        },
      },
      n = {
        description = "Note",
        template = "** %?",
        target = "~/work_org/main.org",
        datetree = {
          tree_type = "custom",
          tree = {
            { format = "%y%m%d", pattern = "^(%d%d)(%d%d)(%d%d)$", order = { 1, 2, 3 } },
          },
        },
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
    {
      "<leader>nu",
      function()
        local pickers = require "telescope.pickers"
        local finders = require "telescope.finders"
        local conf = require("telescope.config").values
        local action_state = require "telescope.actions.state"
        local actions = require "telescope.actions"
        local orgfiles = require("orgmode").files

        local results = {}
        for _, file in ipairs(orgfiles:all()) do
          for _, headline in ipairs(file:get_headlines()) do
            if headline:get_level() == 2 and #headline:get_tags() == 0 then
              table.insert(results, {
                file = file.filename,
                line = headline:get_range().start_line,
                title = headline:get_title(),
              })
            end
          end
        end

        pickers.new({}, {
          prompt_title = "Untagged Level 2 Headings",
          finder = finders.new_table {
            results = results,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.title,
                ordinal = entry.title,
                filename = entry.file,
                lnum = entry.line,
              }
            end,
          },
          sorter = conf.generic_sorter {},
          previewer = conf.grep_previewer {},
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              vim.cmd("edit " .. selection.filename)
              vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
            end)
            return true
          end,
        }):find()
      end,
      desc = "Untagged headings",
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
        vim.schedule_wrap(
          function()
            vim.fn.jobstart {
              "sh",
              "-c",
              string.format(
                'cd ~/work_org && git add "%s" && (git diff --cached --quiet "%s" || (git commit -m "Update %s" && git push))',
                filename,
                filename,
                filename
              ),
            }
          end
        )
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

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.keymap.set("i", "<S-CR>", '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
          silent = true,
          buffer = true,
        })
      end,
    })
  end,
}
