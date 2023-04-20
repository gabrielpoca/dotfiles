vim.g.mapleader = ' '

require('global')

local fn = vim.fn
local execute = vim.api.nvim_command
local cmd = vim.cmd

vim.g.polyglot_disabled = {'solidity', 'svelte'}

-- defaults
local indent = 2

cmd 'syntax enable'
cmd 'filetype plugin indent on'

vim.o.signcolumn = 'number'
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
vim.o.laststatus = 2
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
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.pyxversion = 0
vim.o.dictionary = vim.o.dictionary .. "/usr/share/dict/words"
vim.o.clipboard = "unnamed" -- copy to system clipboard
vim.o.hidden = true
vim.o.termguicolors = true
vim.o.showmatch = false
vim.o.foldenable = false

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function() vim.highlight.on_yank {on_visual = false} end
})

-- clear highlights
set_keymap('n', '<leader><cr>', '<cmd>noh<CR>')
-- escape
set_keymap('t', '<C-e>', '<C-\\><C-n>', {silent = true})
set_keymap('i', 'jk', '<Esc>')
-- save
set_keymap('i', '<C-s>', '<Esc>:w<CR>', {silent = true})
set_keymap('', '<C-s>', ':w<CR>', {silent = true})
-- close window
set_keymap('', '<C-q>', ':close<CR>', {silent = true})
set_keymap('t', '<C-q>', '<C-\\><C-n>:close<CR>', {silent = true})

cmd [[
"keep visual mode after indent
vnoremap > >gv
vnoremap < <gv
]]

cmd [[
" yank whole line
nnoremap Y Y
]]

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.cmd 'packadd packer.nvim'
end

require('my_plugins')
require('colors').setup(os.getenv("COLORSCHEME"),
                        os.getenv("COLORSCHEME_VARIANT"))
require('terminal')
require('repl')
require('tests')
require('navigation')
require('git')
require('which_key')

vim.g.svelte_preprocessors = {'typescript'}
vim.g.AutoPairsMultilineClose = 1
vim.g.any_jump_disable_default_keybindings = 1
vim.g.cursorhold_updatetime = 100
vim.g.localvimrc_sandbox = false
vim.g.localvimrc_whitelist = {'/Users/gabriel/Developer/.*'}
vim.g.terraform_fmt_on_save = 1
vim.g.typescript_indent_disable = 1
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_markdown_folding_disabled = 1
vim.g.loaded_matchparen = 1 -- matchparen seems to be slow

require('lsp')
