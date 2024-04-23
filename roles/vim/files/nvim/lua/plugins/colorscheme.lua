return {
  {
    "f-person/auto-dark-mode.nvim",
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = "dark"
      end,
      set_light_mode = function()
        vim.o.background = "light"
      end,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = colorscheme() ~= "tokyonight",
    priority = 1000,
    opts = {},
    name = "tokyonight",
    config = function()
      require("tokyonight").setup({
        style = "night",
        light_style = "day",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "transparent",
          floats = "transparent",
        },
        sidebars = { "qf", "help" },
        use_background = true,
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
        on_highlights = function(highlights, colors)
          local bg = colors.bg
          local bg_dark = colors.bg_dark
          local fg = colors.fg
          local fg_dark = colors.fg_dark
          local fg_gutter = colors.fg_gutter

          highlights.BufferCurrent = { bg = bg, fg = colors.fg }
          highlights.BufferCurrentMod = { bg = bg, fg = colors.yellow }
          highlights.BufferCurrentSign = { bg = bg, fg = bg }
          highlights.BufferCurrentSignRight = { bg = bg, fg = bg }
          highlights.BufferTabpageFill = { bg = bg_dark, fg = fg }
          highlights.BufferInactive = { bg = bg_dark, fg = fg_gutter }
          highlights.BufferInactiveMod = { bg = bg_dark, fg = colors.orange }
          highlights.BufferInactiveSign = { bg = bg_dark, fg = bg }
          highlights.BufferVisible = { bg = bg, fg = fg_gutter }
          highlights.BufferVisibleMod = { bg = bg, fg = colors.orange }
          highlights.BufferVisibleSign = { bg = bg, fg = bg }
        end,
      })

      vim.api.nvim_command("colorscheme tokyonight")
    end,
  },
  {
    "catppuccin/nvim",
    lazy = colorscheme() ~= "catppuccin",
    dependencies = "lukas-reineke/indent-blankline.nvim",
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").compile()
      require("catppuccin").setup({
        integrations = {
          barbar = true,
          cmp = true,
          hop = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          mason = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          nvimtree = true,
          octo = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
        background = { light = "latte", dark = "mocha" },
        custom_highlights = function(colors)
          local bg = colors.base

          return {
            BufferCurrent = { bg = bg, fg = colors.text },
            BufferCurrentMod = { bg = bg, fg = colors.yellow },
            BufferCurrentSign = { bg = bg, fg = bg },
            BufferCurrentSignRight = { bg = bg, fg = bg },

            BufferTabpageFill = { bg = colors.base, fg = bg },

            BufferInactive = { bg = bg, fg = colors.surface2 },
            BufferInactiveMod = { bg = bg, fg = bg },
            BufferInactiveSign = { bg = bg, fg = bg },

            BufferVisible = { bg = bg, fg = colors.overlay0 },
            BufferVisibleMod = { bg = bg, fg = bg },
            BufferVisibleSign = { bg = bg, fg = bg },
          }
        end,
      })

      vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
}
