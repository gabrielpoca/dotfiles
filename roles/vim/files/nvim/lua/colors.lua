local catppuccin = require("catppuccin")
local lualine = require('lualine')
local wk = require("which-key")

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

local function setup_catppuccin()
    catppuccin.setup({
        background = {light = 'latte', dark = 'mocha'},
        custom_highlights = function(colors)
            return {
                FloatermBorder = {bg = colors.base, fg = colors.blue},
                Floaterm = {bg = colors.mantle},
                BufferCurrent = {bg = colors.surface0},
                BufferCurrentSign = {bg = colors.surface0, fg = colors.surface0},
                BufferCurrentMod = {bg = colors.base, fg = colors.yellow},
                BufferTabpageFill = {bg = colors.base, fg = colors.surface0},
                BufferVisible = {bg = colors.base, fg = colors.surface0},
                BufferVisibleSign = {bg = colors.base, fg = colors.surface0},
                BufferVisibleMod = {bg = colors.base, fg = colors.surface0},
                BufferInactive = {bg = colors.base, fg = colors.surface0},
                BufferInactiveSign = {bg = colors.base, fg = colors.surface0},
                BufferInactiveMod = {bg = colors.base, fg = colors.surface0}
            }
        end
    })

    api.nvim_command('colorscheme catppuccin')
end

local colorscheme = os.getenv("COLORSCHEME")

local function sync_background()
    if os.execute("defaults read -g AppleInterfaceStyle 2> /dev/null") == 0 then
        vim.o.background = 'dark'
    else
        vim.o.background = 'light'
    end
end

M.setup = function()
    vim.o.termguicolors = true

    if colorscheme == 'gruvbox' then
        setup_gruvbox()
    elseif colorscheme == "dracula" then
        setup_dracula()
    elseif colorscheme == "catppuccin" then
        setup_catppuccin()
    end

    sync_background()

    wk.register({c = {s = {sync_background, "Sync colorscheme"}}},
                {prefix = "<leader>", nowait = true})

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
