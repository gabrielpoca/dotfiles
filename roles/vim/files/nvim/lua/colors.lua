local catppuccin = require("catppuccin")
local lualine = require('lualine')

local api = vim.api
local M = {}

M.setup = function(colorscheme)
    vim.o.termguicolors = true
    vim.o.background = "dark"

    if colorscheme == 'gruvbox' then
        vim.g.gruvbox_contrast_dark = "hard"
        vim.g.gruvbox_italic = 1

        vim.cmd [[augroup MyColors]]
        vim.cmd [[autocmd!]]
        vim.cmd [[autocmd ColorScheme * hi FloatermBorder guibg=Normal guifg=#928374]]
        vim.cmd [[autocmd ColorScheme * hi Floaterm guibg=Normal]]
        vim.cmd [[autocmd ColorScheme * hi SignColumn guibg=Normal]]
        vim.cmd [[autocmd ColorScheme * hi Pmenu guibg=Normal]]
        vim.cmd [[augroup END]]

        api.nvim_command('colorscheme ' .. colorscheme)

        api.nvim_set_var('fzf_colors', {
            fg = {'fg', 'GruvboxFg3'},
            bg = {'bg', 'Normal'},
            hl = {'fg', 'MyPurple'},
            ['fg+'] = {'fg', 'Normal'},
            ['bg+'] = {'bg', 'Normal'},
            ['hl+'] = {'fg', 'Normal'},
            info = {'fg', 'GruvboxFg4'},
            border = {'fg', 'StatusLine'},
            prompt = {'fg', 'GruvboxGreen'},
            pointer = {'fg', 'GruvboxGreen'},
            marker = {'fg', 'GruvboxYellow'},
            spinner = {'fg', 'Label'},
            header = {'fg', 'Comment'}
        })
    elseif colorscheme == "dracula" then
        api.nvim_command('colorscheme ' .. colorscheme)

        vim.cmd [[augroup MyColors]]
        vim.cmd [[autocmd!]]
        vim.cmd [[hi! link FloatermBorder DraculaBgDark]]
        vim.cmd [[hi! link Floaterm DraculaBgDark]]
        vim.cmd [[augroup END]]

        api.nvim_set_var('fzf_colors', {
            fg = {'fg', 'DraculaFg'},
            bg = {'bg', 'DraculaBgDark'},
            hl = {'fg', 'DraculaCyan'},
            ['fg+'] = {'fg', 'Normal'},
            ['bg+'] = {'bg', 'Normal'},
            ['hl+'] = {'fg', 'Normal'},
            -- info =    {'fg', 'DraculaBgLight'},
            border = {'fg', 'StatusLine'},
            prompt = {'fg', 'draculacomment'},
            pointer = {'fg', 'DraculaCyan'},
            marker = {'fg', 'DraculaYellow'},
            spinner = {'fg', 'Label'},
            header = {'fg', 'Comment'}
        })
    elseif colorscheme == "catppuccin" then
        catppuccin.setup()
        vim.g.catppuccin_flavour = "mocha"

        api.nvim_command('colorscheme ' .. colorscheme)

        local colors = require("catppuccin.palettes").get_palette()

        local group = vim.api.nvim_create_augroup("mycolors", {});

        local command = vim.fn.join({
            "hi! FloatermBorder guibg=" .. colors.mantle,
            "hi! Floaterm guibg=" .. colors.mantle,
            "hi! BufferCurrentSign guifg=" .. colors.subtext0,
            "hi! BufferCurrentMod guibg=" .. colors.base .. " guifg=" ..
                colors.yellow,
            "hi! BufferTabpageFill guibg=" .. colors.base .. " guifg=" ..
                colors.surface2,
            "hi! BufferVisible guibg=" .. colors.base .. " guifg=" ..
                colors.surface2,
            "hi! BufferVisibleSign guibg=" .. colors.base .. " guifg=" ..
                colors.surface2,
            "hi! BufferVisibleMod guibg=" .. colors.base .. " guifg=" ..
                colors.surface2,
            "hi! BufferInactive guibg=" .. colors.base .. " guifg=" ..
                colors.surface2,
            "hi! BufferInactiveSign guibg=" .. colors.base .. " guifg=" ..
                colors.surface2,
            "hi! BufferInactiveMod guibg=" .. colors.base .. " guifg=" ..
                colors.surface2
        }, "\n\n")

        vim.api.nvim_create_autocmd('VimEnter',
                                    {group = group, command = command})
    end

    lualine.setup({
        options = {theme = colorscheme, disabled_filetypes = {'NvimTree'}}
    })
end

return M
