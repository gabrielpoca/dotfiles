local catppuccin = require("catppuccin")
local lualine = require('lualine')

local api = vim.api
local M = {}

local function setup_gruvbox()
    vim.g.gruvbox_contrast_dark = "hard"
    vim.g.gruvbox_italic = 1

    vim.cmd [[augroup MyColors]]
    vim.cmd [[autocmd!]]
    vim.cmd [[autocmd ColorScheme * hi FloatermBorder guibg=Normal guifg=#928374]]
    vim.cmd [[autocmd ColorScheme * hi Floaterm guibg=Normal]]
    vim.cmd [[autocmd ColorScheme * hi SignColumn guibg=Normal]]
    vim.cmd [[autocmd ColorScheme * hi Pmenu guibg=Normal]]
    vim.cmd [[augroup END]]

    api.nvim_command('colorscheme gruvbox')
end

local function setup_dracula()
    api.nvim_command('colorscheme dracula')

    vim.cmd [[augroup MyColors]]
    vim.cmd [[autocmd!]]
    vim.cmd [[hi! link FloatermBorder DraculaBgDark]]
    vim.cmd [[hi! link Floaterm DraculaBgDark]]
    vim.cmd [[augroup END]]
end

local function setup_catppuccin(variant)
    catppuccin.setup({flavour = variant})

    api.nvim_command('colorscheme catppuccin')

    local colors = require("catppuccin.palettes").get_palette()

    local group = vim.api.nvim_create_augroup("mycolors", {});

    local command = vim.fn.join({
        "hi! FloatermBorder guibg=" .. colors.base .. " guifg=" .. colors.blue,
        "hi! Floaterm guibg=" .. colors.mantle,
        "hi! BufferCurrent guibg=" .. colors.surface0,
        "hi! BufferCurrentSign guibg=" .. colors.surface0 .. " guifg=" ..
            colors.surface0,
        "hi! BufferCurrentMod guibg=" .. colors.base .. " guifg=" ..
            colors.yellow,
        "hi! BufferTabpageFill guibg=" .. colors.base .. " guifg=" ..
            colors.surface0,
        "hi! BufferVisible guibg=" .. colors.base .. " guifg=" ..
            colors.surface0,
        "hi! BufferVisibleSign guibg=" .. colors.base .. " guifg=" ..
            colors.surface0,
        "hi! BufferVisibleMod guibg=" .. colors.base .. " guifg=" ..
            colors.surface0,
        "hi! BufferInactive guibg=" .. colors.base .. " guifg=" ..
            colors.surface0,
        "hi! BufferInactiveSign guibg=" .. colors.base .. " guifg=" ..
            colors.surface0,
        "hi! BufferInactiveMod guibg=" .. colors.base .. " guifg=" ..
            colors.surface0
    }, "\n\n")

    vim.api.nvim_create_autocmd('VimEnter', {group = group, command = command})
end

M.setup = function(colorscheme, variant)
    vim.o.termguicolors = true
    vim.o.background = "dark"

    if colorscheme == 'gruvbox' then
        setup_gruvbox()
    elseif colorscheme == "dracula" then
        setup_dracula()
    elseif colorscheme == "catppuccin" then
        setup_catppuccin(variant)
    end

    lualine.setup({
        options = {
            show_filename_only = false,
            globalstatus = true,
            theme = colorscheme,
            ignore_focus = {'TelescopePrompt', 'NvimTree', 'TelescopeResults'},
            disabled_filetypes = {{}}
        },
        sections = {lualine_c = {{'filename', path = 1}}}
    })
end

return M
