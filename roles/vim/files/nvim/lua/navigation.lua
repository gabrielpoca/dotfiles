-- clear search
vim.api.nvim_set_keymap('n', '<leader><cr>', ':nohlsearch<cr><C-L>', { silent = true, noremap = true })

-- nerdtree

vim.cmd("au FileType nerdtree set nocursorcolumn")

vim.g.NERDTreeWinPos = "left"
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeMinimalMenu = 1
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeStatusline = "%{''}"

set_keymaps({
        ['<Leader>nn'] = 'NERDTreeToggle',
        ['<Leader>nf'] = 'NERDTreeFind',
    })

-- fzf

vim.g.fzf_buffers_jump = 1
vim.g.fzf_layout = { window = { width = 0.9, height = 0.8 } }

vim.api.nvim_set_keymap('i', '<c-x><c-k>', '<plug>(fzf-complete-word)', {})
vim.api.nvim_set_keymap('i', '<c-x><c-f>', '<plug>(fzf-complete-path)', {})

set_keymaps({
        ['<Leader>p'] = 'Files',
        ['<Leader>o'] = 'Buffers',
        --['<Leader>i'] = 'Lines',
        ['<Leader>w'] = 'Ag <C-R><C-W>',
    })


vim.api.nvim_set_keymap('n', '<Leader>f', ':Rg ', { noremap = true })


-- projectionist

vim.g.projectionist_heuristics = {
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
