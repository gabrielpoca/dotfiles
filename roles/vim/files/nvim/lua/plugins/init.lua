return {
	{ "AndrewRadev/splitjoin.vim", lazy = false },
	{ "gcmt/wildfire.vim", lazy = false },
	{ "tpope/vim-abolish", lazy = false },
	{ "tpope/vim-commentary", lazy = false },
	{ "tpope/vim-surround", lazy = false },
	{
		"vim-test/vim-test",
		keys = {
			{ "<leader>ra", "<cmd>TestSuite<CR>", desc = "Run test suite" },
			{ "<leader>rt", "<cmd>TestFile<CR>", desc = "Run test file" },
			{ "<leader>rr", "<cmd>TestNearest<CR>", desc = "Run test line" },
			{ "<leader>rl", "<cmd>TestLast<CR>", desc = "Run last test" },
		},
	},
	{
		"voldikss/vim-floaterm",
		init = function()
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
		keys = {
			{ "<leader>tt", ":FloatermToggle<CR>", desc = "Toggle terminal" },
			{ "<leader>tl", ":FloatermNext<CR>", desc = "Next terminal" },
			{ "<leader>th", ":FloatermPrev<CR>", desc = "Previous terminal" },
			{ "<leader>tk", ":FloatermKill<CR>", desc = "Kill terminal" },
		},
	},
	{
		dir = "~/Developer/replacer.nvim",
		keys = {
			{
				"<leader>h",
				function()
					require("replacer").run()
				end,
				desc = "run replacer.nvim",
			},
		},
	},
	{
		"gabrielpoca/term_find.nvim",
		opts = {
			autocmd_pattern = "floaterm",
			keymap_mode = "n",
			keymap_mapping = "gf",
			callback = function()
				vim.cmd("FloatermHide")
			end,
		},
	},
	{ "NvChad/nvim-colorizer.lua", lazy = false, config = true },
	{
		"RRethy/vim-illuminate",
		lazy = false,
		config = function()
			require("illuminate").configure({
				filetypes_denylist = { "NvimTree" },
				min_count_to_highlight = 2,
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = "G",
		keys = {
			{ "<leader>gs", "<cmd>vertical G<CR>", desc = "Git status" },
			{ "<leader>gb", "<cmd>G blame<CR>", desc = "Git blame" },
			{ "<leader>gp", "<cmd>G push<CR>", desc = "Git push" },
			{ "<leader>go", "<cmd>G browse<CR>", desc = "Git browse" },
			{
				"<leader>gh",
				function()
					require("git").file_history()
				end,
				desc = "Git history for file",
			},
		},
	},
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = true,
		cmd = "Octo",
		keys = { { "<leader>gP", "<cmd>Octo pr list<CR>", desc = "List PRs" } },
	},
	-- 'morhetz/gruvbox',
	-- 'dracula/vim',
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "./snippets" },
			})
		end,
	},
	{
		"folke/which-key.nvim",
		lazy = false,
		config = function()
			local wk = require("which-key")

			wk.register({
				b = { name = "buffer" },
				f = { name = "search" },
				g = { name = "git" },
				l = { name = "language" },
				j = { name = "jump" },
				t = { name = "terminal" },
				r = { name = "tests" },
				n = { name = "tree" },
				c = { name = "colorscheme" },
				e = {
					name = "shell",
					s = {
						function()
							require("repl").start()
						end,
						"Start server",
					},
					r = {
						function()
							require("repl").recompile()
						end,
						"Recompile",
					},
					l = {
						function()
							require("repl").send_line()
						end,
						"Send line",
					},
					i = {
						function()
							require("repl").install()
						end,
						"Setup projet",
					},
				},
				i = {
					function()
						require("terminal").toggle(1)
					end,
					"General terminal",
				},
				u = {
					function()
						require("terminal").toggle(2)
					end,
					"Tests terminal",
				},
			}, { prefix = "<leader>", nowait = true })
		end,
	},
}
