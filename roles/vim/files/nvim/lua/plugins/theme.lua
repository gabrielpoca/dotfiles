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
						os.execute("kitty +kitten themes --reload-in=all Catppuccin Kitty Latte")
					else
						os.execute(
							"sed -i '' -e \"s/^colors: .*$/colors: *catppuccin_mocha/\" $DOTFILES/roles/shell/files/alacritty/alacritty.yml"
						)
						os.execute("kitty +kitten themes --reload-in=all Catppuccin Kitty Mocha")
					end
				end,
			})
		end,
	},
	{
		"catppuccin/nvim",
		dependencies = "lukas-reineke/indent-blankline.nvim",
		lazy = false,
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
			})
		end,
	},
}
