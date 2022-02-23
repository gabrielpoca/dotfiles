local repl = require('repl')

vim.g["test#custom_strategies"] = {
	myrepl = function (cmd) repl.run_test(cmd) end,
}

vim.g["test#strategy"] = 'myrepl'
