function TermJump()
    local word = vim.fn.expand("<cWORD>"):match("^[%s[(]*(.-)[%s%]%)]*$")
    local parts = vim.fn.split(word, ":");
    local f = vim.fn.findfile(parts[1])

    if f == "" then return end

    vim.cmd("FloatermHide")
    vim.cmd("edit " .. f)

    if empty(parts[2]) and empty(parts[3]) then return end

    if empty(parts[3]) then
        vim.api.nvim_win_set_cursor(0, {tonumber(parts[2]), 1})
    else
        vim.api.nvim_win_set_cursor(0, {tonumber(parts[2]), tonumber(parts[3])})
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "floaterm",
    callback = function() vim.keymap.set("n", "gf", TermJump) end
})

-- clear search highlights
vim.api.nvim_set_keymap('n', '<leader><cr>', ':nohlsearch<cr><C-L>',
                        {silent = true, noremap = true})

-- projectionist
vim.g.projectionist_heuristics = {
    ["Gemfile"] = {
        ['app/*.rb'] = {['alternate'] = 'spec/{}_spec.rb', ['type'] = 'source'},
        ['spec/*_spec.rb'] = {['alternate'] = 'app/{}.rb', ['type'] = 'test'}
    },
    ["spec/support/jasmine.json"] = {
        ['src/*.js'] = {['alternate'] = 'src/{}.spec.js', ['type'] = 'source'},
        ['src/*.spec.js'] = {['alternate'] = 'src/{}.js', ['type'] = 'test'}
    },
    ["package.json"] = {
        ['src/*.js'] = {['alternate'] = '{}.test.js', ['type'] = 'source'},
        ['src/*.test.js'] = {['alternate'] = 'src/{}.js', ['type'] = 'test'}
    },
    ["mix.exs"] = {
        ['lib/*_live.ex'] = {
            ['alternate'] = 'lib/{}_live.html.leex',
            ['type'] = 'source'
        },
        ['lib/*.ex'] = {['alternate'] = 'test/{}_test.exs', ['type'] = 'source'},
        ['test/*_test.exs'] = {['alternate'] = 'lib/{}.ex', ['type'] = 'test'},
        ['lib/*.html.leex'] = {
            ['alternate'] = 'lib/{}.ex',
            ['type'] = 'live_view'
        }
    }
}

