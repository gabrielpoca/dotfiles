-- clear search highlights
vim.api.nvim_set_keymap('n', '<leader><cr>', ':nohlsearch<cr><C-L>', { silent = true, noremap = true })

-- tree explorer

vim.g.coc_explorer_global_presets = {
  ['floating'] =  {
    ['position'] = 'floating',
    ['floating-width'] = -40,
    ['open-action-strategy'] = 'sourceWindow',
    ['file-child-template'] = '[git | 2] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1][filename omitCenter 1][modified][readonly] [linkIcon & 1][link growRight 1 omitCenter 5]'
  }
}

set_keymaps({
        ['<Leader>nn'] = 'CocCommand explorer --preset floating'
    })


-- fzf
vim.g.fzf_buffers_jump = 1
vim.g.fzf_layout = { window = { width = 0.9, height = 0.8 } }

vim.g.fzf_preview_custom_processes = {
    ['open-file'] = {
        ['ctrl-o'] = 'FzfPreviewOpenFileCtrlO',
        ['ctrl-t'] = 'FzfPreviewOpenFileCtrlQ',
        ['ctrl-v'] = 'FzfPreviewOpenFileCtrlV',
        ['ctrl-x'] = 'FzfPreviewOpenFileCtrlX',
        ['enter'] = 'FzfPreviewOpenFileEnter'
    }
}

set_keymaps({
        ['<Leader>p'] = 'Files',
        ['<Leader>o'] = 'Buffers',
        --['<Leader>i'] = 'Lines',
        ['<Leader>w'] = 'Ag <C-R><C-W>',
    })

vim.api.nvim_set_keymap('n', '<Leader>f', ':Rg ', { noremap = true })
vim.api.nvim_set_keymap('i', '<c-x><c-k>', '<plug>(fzf-complete-word)', {})
vim.api.nvim_set_keymap('i', '<c-x><c-f>', '<plug>(fzf-complete-path)', {})
vim.api.nvim_set_keymap('n', '<leader>p', ':Files<CR>', { silent = true, noremap= true })
--vim.api.nvim_set_keymap('n', '<leader>o', ':<C-u>CocCommand fzf-preview.Buffers<CR>', { silent = true, noremap= true })
--vim.api.nvim_set_keymap('x', '<leader>w', "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>\"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>", { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>w', '"sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-R><C-W>"', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>f', ':<C-u>CocCommand fzf-preview.ProjectGrep<Space>', { noremap = true })

-- projectionist
vim.g.projectionist_heuristics = {
    ["Gemfile"] = {
        ['app/*.rb'] = {
            ['alternate'] = 'spec/{}_spec.rb',
            ['type'] = 'source',
        },
        ['spec/*_spec.rb'] = {
            ['alternate'] = 'app/{}.rb',
            ['type'] = 'test',
        },
    },
    ["spec/support/jasmine.json"] = {
        ['src/*.js'] = {
            ['alternate'] = 'src/{}.spec.js',
            ['type'] = 'source',
        },
        ['src/*.spec.js'] = {
            ['alternate'] = 'src/{}.js',
            ['type'] = 'test',
        }
    },
    ["package.json"] = {
        ['src/*.js'] = {
            ['alternate'] = '{}.test.js',
            ['type'] = 'source',
        },
        ['src/*.test.js'] = {
            ['alternate'] = 'src/{}.js',
            ['type'] = 'test',
        }
    },
    ["mix.exs"] = {
        ['lib/*_live.ex'] = {
            ['alternate'] = 'lib/{}_live.html.leex',
            ['type'] = 'source',
        },
        ['lib/*.ex'] = {
            ['alternate'] = 'test/{}_test.exs',
            ['type'] = 'source',
        },
        ['test/*_test.exs'] = {
            ['alternate'] = 'lib/{}.ex',
            ['type'] = 'test',
        },
        ['lib/*.html.leex'] = {
            ['alternate'] = 'lib/{}.ex',
            ['type'] = 'live_view',
        }
    }
}

set_keymaps({
        ['<Leader>a'] = 'A',
        ['<Leader>v'] = 'AV',
    })
