return {
	{
		"romgrk/barbar.nvim",
		lazy = false,
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = { insert_at_start = true },
		keys = {
			{ "<leader>1", ":BufferGoto 1<CR>", desc = "Go to buffer 1" },
			{ "<leader>2", ":BufferGoto 2<CR>", desc = "Go to buffer 2" },
			{ "<leader>3", ":BufferGoto 3<CR>", desc = "Go to buffer 3" },
			{ "<leader>4", ":BufferGoto 4<CR>", desc = "Go to buffer 4" },
			{ "<leader>5", ":BufferGoto 5<CR>", desc = "Go to buffer 5" },
			{ "<leader>6", ":BufferGoto 6<CR>", desc = "Go to buffer 6" },
			{ "<leader>7", ":BufferGoto 7<CR>", desc = "Go to buffer 7" },
			{ "<leader>bn", ":BufferNext<CR>", desc = "Next" },
			{ "<leader>bp", ":BufferPrevious<CR>", desc = "Previous" },
			{ "<leader>bd", ":BufferCloseAllButCurrent<CR>", desc = "Close other buffers" },
			{ "<leader>bb", ":BufferOrderByBufferNumber<CR>", desc = "Order by number" },
			{ "<leader>bl", ":BufferOrderByLanguage<CR>", desc = "Order by language" },
			{ "<leader>bo", ":BufferPick<CR>", desc = "Pick buffer" },
		},
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>bq",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bQ",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
}
