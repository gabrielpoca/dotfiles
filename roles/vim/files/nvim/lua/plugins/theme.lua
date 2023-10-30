return {
	{
		"cormacrelf/dark-notify",
		lazy = false,
		config = function()
			require("dark_notify").run({
				onchange = function(mode)
					if mode == "light" then
						os.execute(
							"sed -i '' -e \"s/^colors: .*$/colors: *catppuccin_latte/\" $DOTFILES/roles/shell/files/alacritty/alacritty.yml"
						)
						-- os.execute("kitty +kitten themes --reload-in=all Catppuccin Kitty Latte")
					else
						os.execute(
							"sed -i '' -e \"s/^colors: .*$/colors: *catppuccin_mocha/\" $DOTFILES/roles/shell/files/alacritty/alacritty.yml"
						)
						-- os.execute("kitty +kitten themes --reload-in=all Catppuccin Kitty Mocha")
					end
				end,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = colorscheme() ~= "tokyonight",
		priority = 1000,
		opts = {},
		name = "tokyonight",
		config = function()
			vim.api.nvim_command("colorscheme tokyonight-" .. colorscheme_variant())
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
