require'nvim-tree'.setup {}

local M = {}

M.term_jump = function ()
  local parts = vim.fn.split(vim.fn.expand("<cWORD>"), ":");
  local f = vim.fn.findfile(parts[1])

  if f ~= "" then
    vim.cmd("FloatermHide")
    vim.cmd("edit " .. f)

    if vim.fn.empty(parts[2]) == 0 and vim.fn.empty(parts[3]) == 0 then
      vim.api.nvim_win_set_cursor(win_id, {tonumber(parts[2]), tonumber(parts[3])})
    elseif vim.fn.empty(parts[2]) == 0 then
      vim.api.nvim_win_set_cursor(win_id, {tonumber(parts[2]), 1})
    end
  end
end

vim.cmd("autocmd FileType floaterm nnoremap <silent><buffer> gf :lua require('navigation').term_jump()<CR>")

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

return M;
