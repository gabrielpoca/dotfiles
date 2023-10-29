return {
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

			vim.g.floaterm_width = 0.9
			vim.g.floaterm_height = 0.9
			-- vim.g.floaterm_borderchars = '        '
			vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
			vim.g.floaterm_titleposition = "center"
			vim.g.floaterm_autoinsert = false
			vim.g.floaterm_autohide = true
			-- vim.g.floaterm_title = ''
			-- vim.g.floaterm_title = ' ($1|$2) '
		end,
	},
}
