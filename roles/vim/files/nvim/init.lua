vim.g.mapleader = ' '

require('global')

local fn = vim.fn
local execute = vim.api.nvim_command
local cmd = vim.cmd

vim.g.polyglot_disabled = { 'solidity', 'svelte' }

-- defaults
local indent = 2

cmd 'syntax enable'
cmd 'filetype plugin indent on'

vim.o.signcolumn = 'number'
vim.o.cmdheight = 1
vim.o.updatetime = 300
vim.o.shell="/bin/zsh"
vim.o.autoread = true
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undodir= fn.expand("$HOME") .. "/.vim/undo"
vim.o.undofile = true
vim.o.rnu = true
vim.o.nu = true
vim.o.expandtab = true
vim.o.tabstop=2
vim.o.shiftwidth=2
vim.o.wrap = false
vim.o.wildmenu = true
vim.o.wildmode="full"
vim.o.wildoptions="pum"
vim.o.pumblend=20
vim.o.laststatus=2
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
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- Basic Keymaps

-- clear highlights
set_keymap('n', '<leader><cr>', '<cmd>noh<CR>')
-- escape
set_keymap('t', '<C-e>', '<C-\\><C-n>', { silent = true })
set_keymap('i', 'jk', '<Esc>')
-- save
set_keymap('i', '<C-s>', '<Esc>:w<CR>', { silent = true })
set_keymap('', '<C-s>', ':w<CR>', { silent = true })
-- close window
set_keymap('', '<C-q>', ':close<CR>', { silent = true })
set_keymap('t', '<C-q>', '<C-\\><C-n>:close<CR>', { silent = true })


-- Auto install packer.nvim if not exists
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

require('my_plugins')
require('legendary').setup()
require('lualine').setup({ options = {theme = 'dracula'} })
require('colors').setup('dracula')
require('terminal')
require('repl')
require('tests')
require('navigation')
require('git')


vim.g.svelte_preprocessors = {'typescript'}
vim.g.AutoPairsMultilineClose = 1
vim.g.any_jump_disable_default_keybindings = 1
vim.g.coq_settings = { keymap = { jump_to_mark = '<c-g>', pre_select = true } }
vim.g.cursorhold_updatetime = 100
vim.g.localvimrc_sandbox = false
vim.g.localvimrc_whitelist = { '/Users/gabriel/Developer/.*' }
vim.g.terraform_fmt_on_save=1
vim.g.typescript_indent_disable = 1
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_markdown_folding_disabled = 1
vim.g.fzf_preview_window = {}
vim.g.loaded_matchparen = 1 -- matchparen seems to be slow

require('telescope_config')
require('lsp')

cmd[[
"keep visual mode after indent
vnoremap > >gv
vnoremap < <gv
]]

cmd[[
" yank whole line
nnoremap Y Y
]]

cmd("autocmd VimEnter * :COQnow -s")

local wk = require("which-key")

wk.register({
  ["1"] = { ":BufferGoto 1<CR>", "Go to buffer 1" },
  ["2"] = { ":BufferGoto 2<CR>", "Go to buffer 2" },
  ["3"] = { ":BufferGoto 3<CR>", "Go to buffer 3" },
  ["4"] = { ":BufferGoto 4<CR>", "Go to buffer 4" },
  ["5"] = { ":BufferGoto 5<CR>", "Go to buffer 5" },
  ["6"] = { ":BufferGoto 6<CR>", "Go to buffer 6" },
  ["7"] = { ":BufferGoto 7<CR>", "Go to buffer 7" },
  a = { ":A<CR>", "Change to alternate" },
  b = {
    name = "buffer",
    n = { ":BufferNext<CR>", "Next" },
    p = { ":BufferPrevious<CR>", "Previous" },
    q = { ":BufferClose<CR>", "Close" },
    b = { ":BufferOrderByBufferNumber<CR>", "Order by number" },
    d = { ":BufferOrderByDirectory<CR>", "Order by directory" },
    l = { ":BufferOrderByLanguage<CR>", "Order by language" },
  },
  e = {
    name = "shell",
    s = { ":lua require'repl'.start()<CR>", "Start server" },
    r = { ":lua require'repl'.recompile()<CR>", "Recompile" },
    l = { ":lua require'repl'.send_line()<CR>", "Send line" },
    i = { ":lua require'repl'.install()<CR>", "Setup projet" },
  },
  f = {
    name = "search",
    w = { ":Ag <C-R><C-W><CR>", "Search for word under cursor" },
    f = { ":Ag ", "Search for word input", silent = false },
  },
  g = {
    name = "git",
    s = { ":vertical G<CR>", "Status" },
    h = { ':lua require"git".file_history()<CR>',  "History for the current file" },
    b = { ":Gblame<CR>", "Blame" },
    p = { ":Octo pr list<CR>", "List PRs" },
  },
  h = { ":lua require('replacer').run()<cr>", "replacer.nvim" },
  j = {
    name = "jump",
    j = { ":AnyJump<CR>", "Open" },
    k = { ":AnyJumpLastResults<CR>", "Last Results" },
    w = { ":HopWord<CR>", "Go to word" },
    l = { ":HopLine<CR>", "Go to line" },
  },
  i = { ':lua require"terminal".toggle(1)<CR>', "General terminal" },
  n = {
    name = "tree",
    n = { ":NvimTreeToggle<CR>", "Toggle" },
    f = { ":NvimTreeFindFile<CR>", "Find file" },
  },
  o = { ":Telescope buffers<CR>", "Buffers" },
  p = { ":Telescope find_files<CR>", "Files" },
  t = {
    name = "terminal",
    t = { ":FloatermToggle<CR>", "Toggle terminal" },
    l = { ":FloatermNext<CR>", "Next terminal" },
    h = { ":FloatermPrev<CR>", "Previous terminal" },
  },
  u = { ':lua require"terminal".toggle(2)<CR>', "Tests terminal" },
  r = {
    name = "tests",
    a = { ":TestSuite<CR>", "Run test suite" },
    t = { ":TestFile<CR>", "Run test file" },
    r = { ":TestNearest<CR>", "Run test line" },
    l = { ":TestLast<CR>", "Run last test" },
    d = { ":Tclear<CR>", "Clear terminal" },
    k = { ":Tkill<CR>", "Kill job" },
  },
  v = { ":AV<CR>", "Open alternate file in split" },
  ['<leader>'] = { ":Legendary<CR>", "Search everything" },
}, { prefix = "<leader>", nowait = true })

require('Comment').setup()
require'hop'.setup()
