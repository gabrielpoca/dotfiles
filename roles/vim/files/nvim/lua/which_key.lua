local wk = require("which-key")
local telescope = require('telescope.builtin')

local wk_mappings = {
    ["1"] = {":BufferGoto 1<CR>", "Go to buffer 1"},
    ["2"] = {":BufferGoto 2<CR>", "Go to buffer 2"},
    ["3"] = {":BufferGoto 3<CR>", "Go to buffer 3"},
    ["4"] = {":BufferGoto 4<CR>", "Go to buffer 4"},
    ["5"] = {":BufferGoto 5<CR>", "Go to buffer 5"},
    ["6"] = {":BufferGoto 6<CR>", "Go to buffer 6"},
    ["7"] = {":BufferGoto 7<CR>", "Go to buffer 7"},
    a = {":A<CR>", "Change to alternate"},
    b = {
        name = "buffer",
        n = {":BufferNext<CR>", "Next"},
        p = {":BufferPrevious<CR>", "Previous"},
        q = {":BufferClose<CR>", "Close"},
        b = {":BufferOrderByBufferNumber<CR>", "Order by number"},
        d = {":BufferOrderByDirectory<CR>", "Order by directory"},
        l = {":BufferOrderByLanguage<CR>", "Order by language"},
        o = {":BufferPick<CR>", "Pick buffer"}
    },
    e = {
        name = "shell",
        s = {":lua require'repl'.start()<CR>", "Start server"},
        r = {":lua require'repl'.recompile()<CR>", "Recompile"},
        l = {":lua require'repl'.send_line()<CR>", "Send line"},
        i = {":lua require'repl'.install()<CR>", "Setup projet"}
    },
    f = {
        name = "search",
        w = {
            function() telescope.grep_string(); end,
            "Search for word under cursor"
        },
        f = {
            function() telescope.grep_string({search = ''}); end,
            "Search for input"
        }
    },
    g = {
        name = "git",
        s = {":vertical G<CR>", "Git status"},
        h = {':lua require"git".file_history()<CR>', "Git history for file"},
        b = {":G blame<CR>", "Git blame"},
        P = {":Octo pr list<CR>", "List PRs"},
        p = {":G push<CR>", "Git Push"},
        o = {":G browse<CR>", "Git open in browser"}
    },
    h = {":lua require('replacer').run()<cr>", "replacer.nvim"},
    j = {
        name = "jump",
        j = {":AnyJump<CR>", "Open"},
        k = {":AnyJumpLastResults<CR>", "Last Results"},
        w = {":HopWord<CR>", "Go to word"},
        l = {":HopLine<CR>", "Go to line"}
    },
    i = {':lua require"terminal".toggle(1)<CR>', "General terminal"},
    n = {
        name = "tree",
        n = {":NvimTreeToggle<CR>", "Toggle"},
        f = {":NvimTreeFindFile<CR>", "Find file"}
    },
    o = {function() telescope.buffers(); end, "Buffers"},
    p = {function() telescope.find_files(); end, "Files"},
    t = {
        name = "terminal",
        t = {":FloatermToggle<CR>", "Toggle terminal"},
        l = {":FloatermNext<CR>", "Next terminal"},
        h = {":FloatermPrev<CR>", "Previous terminal"}
    },
    u = {':lua require"terminal".toggle(2)<CR>', "Tests terminal"},
    r = {
        name = "tests",
        a = {":TestSuite<CR>", "Run test suite"},
        t = {":TestFile<CR>", "Run test file"},
        r = {":TestNearest<CR>", "Run test line"},
        l = {":TestLast<CR>", "Run last test"},
        d = {":Tclear<CR>", "Clear terminal"},
        k = {":Tkill<CR>", "Kill job"}
    },
    v = {":AV<CR>", "Open alternate file in split"},
    ['<leader>'] = {":Legendary<CR>", "Search everything"}
}

wk.register(wk_mappings, {prefix = "<leader>", nowait = true})
