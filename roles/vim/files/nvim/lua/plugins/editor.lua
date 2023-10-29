return {
	{ "derekprior/vim-trimmer", lazy = false },
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
					enable = true,
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
	},
	{
		"b0o/incline.nvim",
		event = { "WinNew", "CursorMoved" },
		opts = {
			hide = { cursorline = false, focused_win = true, only_win = false },
			render = function(props)
				local bufname = vim.api.nvim_buf_get_name(props.buf)
				local filename = vim.fn.fnamemodify(bufname, ":t")
				local folder = vim.fn.fnamemodify(bufname, ":~:.:h:t")

				local filetype_icon = require("nvim-web-devicons").get_icon_color(filename)

				return {
					{ filetype_icon },
					{ " " },
					{ string.format("%s/%s", folder, filename) },
				}
			end,
		},
	},
}
