local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup('plugins')

local wk = require("which-key")

local wk_mappings = {
    e = {
        name = "shell",
        s = {function() require'repl'.start() end, "Start server"},
        r = {function() require'repl'.recompile() end, "Recompile"},
        l = {function() require'repl'.send_line() end, "Send line"},
        i = {function() require'repl'.install() end, "Setup projet"}
    },
    i = {function() require"terminal".toggle(1) end, "General terminal"},
    u = {function() require"terminal".toggle(2) end, "Tests terminal"}
}

wk.register(wk_mappings, {prefix = "<leader>", nowait = true})
