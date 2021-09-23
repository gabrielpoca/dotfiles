-- clear search highlights
vim.api.nvim_set_keymap('n', '<leader><cr>', ':nohlsearch<cr><C-L>', { silent = true, noremap = true })

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
