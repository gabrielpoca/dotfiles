if false then
  return {}
else
  ---@type LazySpec
  return {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
      {
        "MeanderingProgrammer/render-markdown.nvim",
        lazy = true,
        opts = function(_, opts)
          opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "codecompanion" })
        end,
      },
      { "echasnovski/mini.diff", opts = {} },
      {
        "rebelot/heirline.nvim",
        opts = function(_, opts)
          local CodeCompanion = {
            static = {
              processing = false,
            },
            update = {
              "User",
              pattern = "CodeCompanionRequest*",
              callback = function(self, args)
                if args.match == "CodeCompanionRequestStarted" then
                  self.processing = true
                elseif args.match == "CodeCompanionRequestFinished" then
                  self.processing = false
                end
                vim.cmd "redrawstatus"
              end,
            },
            {
              condition = function(self) return self.processing end,
              provider = " ",
              hl = { fg = "yellow" },
            },
          }
          require("utils").set_component_left(opts, CodeCompanion)
          return opts
        end,
      },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<leader>a"] = { desc = "󰚩 " .. "AI" }
          maps.v["<leader>a"] = { desc = "󰚩 " .. "AI" }
          maps.n["<leader>at"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle code companion" }
          maps.v["<leader>at"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle code companion" }
          maps.n["<leader>aa"] = { "<cmd>CodeCompanionActions<cr>", desc = "code companion actions" }
          maps.v["<leader>aa"] = { "<cmd>CodeCompanionActions<cr>", desc = "code companion actions" }
          maps.v["ga"] = { "<cmd>codecompanionAdd<cr>", desc = "add selected content as chat context" }
        end,
      },
    },
    opts = {
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = vim.env.ANTHROPIC_API_KEY,
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
        agent = {
          adapter = "anthropic",
        },
        cmd = {
          adapter = "anthropic",
        },
      },
      display = {
        chat = {
          render_headers = false,
          show_settings = true, -- Show LLM settings at the top of the chat buffer?
          show_token_count = true, -- Show the token count for each response?
          start_in_insert_mode = true,
        },
        diff = {
          provider = "mini_diff",
        },
      },
    },
  }
end
