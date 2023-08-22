local Terminal = require "terminal"

local M = {}

local has_file = function(filename)
    local stat = vim.loop.fs_stat(filename)

    return stat and stat.type or false
end

M.send = function(command, terminal) Terminal.toggle(terminal, command) end

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
                M.send('iex -S mix phx.server\n', Terminal.REPL)
            else
                includes("mix.exs", "still", function(result)
                    if result then
                        M.send('iex -S mix still.dev\n', Terminal.REPL)
                    else
                        M.send('iex -S mix\n', Terminal.REPL)
                    end
                end)
            end
        end)
    elseif has_file("Justfile") then
        M.send("just dev\n", Terminal.REPL)
    elseif has_file("yarn.lock") then
        includes("package.json", '"dev"', function(result)
            if result then
                M.send("yarn run dev\n", Terminal.REPL)
            else
                M.send("yarn start\n", Terminal.REPL)
            end
        end)
    elseif has_file("package-lock.json") then
        includes("package.json", "\"dev\"", function(result)
            if result then
                M.send("npm run dev\n", Terminal.REPL)
            else
                M.send("npm start\n", Terminal.REPL)
            end
        end)
    elseif has_file("Cargo.toml") then
        M.send("cargo run\n", Terminal.REPL)
    else
        error('Failed to identify server')
    end
end

M.install = function()
    if has_file("mix.exs") then
        M.send("mix deps.get\n", Terminal.SHELL)
    elseif has_file("yarn.lock") then
        M.send("yarn install\n", Terminal.SHELL)
    elseif has_file("package-lock.json") then
        M.send("npm install\n", Terminal.SHELL)
    end
end

M.recompile =
    function() if has_file("mix.exs") then M.send('recompile\n') end end

M.run_test = function(cmd) M.send(cmd .. "\n", Terminal.SHELL) end

set_keymaps({["<leader>el"] = "lua require'repl'.send_selection()"}, 'v')

return M;
