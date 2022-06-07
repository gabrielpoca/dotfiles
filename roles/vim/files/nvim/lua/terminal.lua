local M = {}

M.toggle = function(terminal, cmd)
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

vim.g.floaterm_width = 0.9
vim.g.floaterm_height = 0.9
vim.g.floaterm_borderchars = '        '
vim.g.floaterm_title = ''
-- vim.g.floaterm_title = ' term ($1|$2) '
vim.g.floaterm_autoinsert = false
vim.g.floaterm_autohide = true

return M
