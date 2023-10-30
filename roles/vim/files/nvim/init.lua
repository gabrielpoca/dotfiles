vim.g.mapleader = " "
vim.g.loaded_matchparen = 1 -- matchparen seems to be slow

require("global")

local fn = vim.fn
local cmd = vim.cmd

cmd("syntax enable")
cmd("filetype plugin indent on")

vim.o.signcolumn = "number"
vim.o.cmdheight = 1
vim.o.updatetime = 300
vim.o.shell = "/opt/homebrew/bin/zsh"
vim.o.autoread = true
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undodir = fn.expand("$HOME") .. "/.vim/undo"
vim.o.undofile = true
vim.o.rnu = true
vim.o.nu = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.wrap = false
vim.o.wildmenu = true
vim.o.wildmode = "full"
vim.o.wildoptions = "pum"
vim.o.wildignore = "*/build/*,*/.git/*"
vim.o.pumblend = 20
vim.o.laststatus = 3
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 6
vim.o.startofline = false
vim.o.synmaxcol = 200
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.gdefault = true
vim.o.inccommand = "nosplit"
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.shortmess = vim.o.shortmess .. "aWCFS"
vim.o.pyxversion = 0
vim.o.dictionary = vim.o.dictionary .. "/usr/share/dict/words"
vim.o.clipboard = "unnamed" -- copy to system clipboard
vim.o.hidden = true
vim.o.termguicolors = true
vim.o.showmatch = false
vim.o.foldenable = false

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ on_visual = false })
	end,
})

-- clear highlights
set_keymap("n", "<leader><cr>", "<cmd>noh<CR>")
-- escape
set_keymap("t", "<C-e>", "<C-\\><C-n>", { silent = true })
set_keymap("i", "jk", "<Esc>")
-- save
set_keymap("i", "<C-s>", "<Esc>:silent write<CR>", { silent = true })
set_keymap("", "<C-s>", ":silent write<CR>", { silent = true })
-- close window
set_keymap("", "<C-q>", ":close<CR>", { silent = true })
set_keymap("t", "<C-q>", "<C-\\><C-n>:close<CR>", { silent = true })

cmd([[
"keep visual mode after indent
vnoremap > >gv
vnoremap < <gv
]])

cmd([[
" yank whole line
nnoremap Y Y
]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("my.colors").setup()
require("my.terminal")
require("my.repl")
require("my.tests")
require("my.git")
require("my.lsp")
