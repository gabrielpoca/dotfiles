local M = {}

M.toggle = function(terminal, cmd)
    local name

    if terminal == 1 or terminal == nil then
        name = "repl"
    else
        name = "shell"
    end

    if vim.call('floaterm#terminal#get_bufnr', name) ~= -1 then
        vim.cmd("FloatermShow " .. name)
    else
        vim.cmd("FloatermNew --name=" .. name)
    end

    if cmd then vim.cmd("FloatermSend --termname=" .. name .. " " .. cmd) end
end

M.REPL = 1
M.SHELL = 2

return M
