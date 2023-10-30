local M = {}

local function get_name(terminal)
	if terminal == M.REPL or terminal == nil then
		return "Repl"
	else
		return "Shell"
	end
end

M.kill = function(terminal)
	local name = get_name(terminal)

	vim.cmd("FloatermKill --termname=" .. name)
end

M.toggle = function(terminal, cmd)
	local name = get_name(terminal)

	if vim.call("floaterm#terminal#get_bufnr", name) ~= -1 then
		vim.cmd("FloatermShow " .. name)
	else
		vim.cmd("FloatermNew --name=" .. name .. " --title=" .. name)
	end

	if cmd then
		vim.cmd("FloatermSend --termname=" .. name .. " " .. cmd)
	end
end

M.REPL = 1
M.SHELL = 2

return M
