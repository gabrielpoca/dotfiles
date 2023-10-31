return {
	{
		"cormacrelf/dark-notify",
		lazy = false,
		config = function()
			require("dark_notify").run({
				onchange = function(mode)
					if mode == "light" then
						os.execute(
							"sed -i '' -e \"s/^colors: .*$/colors: *"
								.. colorscheme()
								.. '_light/" $DOTFILES/roles/shell/files/alacritty/alacritty.yml'
						)
						-- os.execute("kitty +kitten themes --reload-in=all Catppuccin Kitty Latte")
					else
						os.execute(
							"sed -i '' -e \"s/^colors: .*$/colors: *"
								.. colorscheme()
								.. '_dark/" $DOTFILES/roles/shell/files/alacritty/alacritty.yml'
						)
						-- os.execute("kitty +kitten themes --reload-in=all Catppuccin Kitty Mocha")
					end
				end,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = colorscheme() ~= "tokyontight",
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

					highlights.FloatermBorder = { bg = bg, fg = colors.border_highlight }
					-- highlights.Floaterm = { bg = colors.base }
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
					-- highlights.InclineNormal = { bg = colors.overlay1, fg = colors.crust }
					-- highlights.InclineNormalNC = { bg = colors.overlay1, fg = colors.crust }
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
						FloatermBorder = { bg = colors.base, fg = colors.blue },
						Floaterm = { bg = colors.base },

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

						InclineNormal = { bg = colors.overlay1, fg = colors.crust },
						InclineNormalNC = { bg = colors.overlay1, fg = colors.crust },
					}
				end,
			})

			vim.api.nvim_command("colorscheme catppuccin")
		end,
	},
}
