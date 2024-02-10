local Terminal = require("my.terminal")

local M = {}

local has_file = function(filename)
	local stat = vim.loop.fs_stat(filename)

	return stat and stat.type or false
end

M.send = function(command, terminal)
	Terminal.toggle(terminal, command)
end

M.send_line = function()
	local line = vim.api.nvim_get_current_line() .. "\n"
	M.send(line)
end

M.send_selection = function()
	local line1 = vim.fn.getpos("'<")[2]
	local line2 = vim.fn.getpos("'>")[2]

	local lines = ""
	for _, v in pairs(vim.fn.getline(line1, line2)) do
		lines = lines .. v .. "\n"
	end

	M.send(lines)
end

M.start = function()
	if has_file("mix.exs") then
		includes("mix.exs", "phoenix", function(result)
			if result then
				M.send("iex -S mix phx.server\n", "repl")
			else
				includes("mix.exs", "still", function(result)
					if result then
						M.send("iex -S mix still.dev\n", "repl")
					else
						M.send("iex -S mix\n", "repl")
					end
				end)
			end
		end)
	elseif has_file("Justfile") then
		M.send("just dev\n", "repl")
	elseif has_file("yarn.lock") then
		includes("package.json", '"dev"', function(result)
			if result then
				M.send("yarn run dev\n", "repl")
			else
				M.send("yarn start\n", "repl")
			end
		end)
	elseif has_file("package-lock.json") then
		includes("package.json", '"dev"', function(result)
			if result then
				M.send("npm run dev\n", "repl")
			else
				M.send("npm start\n", "repl")
			end
		end)
	elseif has_file("Cargo.toml") then
		M.send("cargo run\n", "repl")
	else
		error("Failed to identify server")
	end
end

M.install = function()
	if has_file("mix.exs") then
		M.send("mix deps.get\n", "shell")
	elseif has_file("yarn.lock") then
		M.send("yarn install\n", "shell")
	elseif has_file("package-lock.json") then
		M.send("npm install\n", "shell")
	end
end

M.recompile = function()
	if has_file("mix.exs") then
		M.send("recompile\n")
	end
end

M.run_test = function(cmd)
	M.send(cmd .. "\n", "shell")
end

set_keymaps({ ["<leader>el"] = "lua require'my.repl'.send_selection()" }, "v")

return M
