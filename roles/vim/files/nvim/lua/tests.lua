local repl = require('repl')

vim.g["test#custom_strategies"] = {
	myrepl = function (cmd) repl.run_test(cmd) end,
}

vim.g["test#strategy"] = 'myrepl'

vim.g.floaterm_title = ' term ($1|$2) '
vim.g.floaterm_autoinsert = false

set_keymaps({
	["<leader>ra"] = "TestSuite",
	["<leader>rt"] = "TestFile",
	["<leader>rr"] = "TestNearest",
	["<leader>rl"] = "TestLast",
	["<leader>rd"] = "Tclear",
	["<leader>rk"] = "Tkill"
})
