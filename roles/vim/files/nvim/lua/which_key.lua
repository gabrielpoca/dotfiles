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
    c = {
        name = "completion",
        c = {function() require('copilot.panel').open({}) end, "Copilot"}
    },
    e = {
        name = "shell",
        s = {function() require'repl'.start() end, "Start server"},
        r = {function() require'repl'.recompile() end, "Recompile"},
        l = {function() require'repl'.send_line() end, "Send line"},
        i = {function() require'repl'.install() end, "Setup projet"}
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
    h = {function() require('replacer').run() end, "replacer.nvim"},
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
        n = {function() require('nvim-tree.api').tree.toggle() end, "Toggle"},
        f = {
            function()
                require('nvim-tree.api').tree.find_file({
                    open = true,
                    focus = true
                })
            end,
            "Find file"
        }
    },
    o = {function() telescope.buffers(); end, "Buffers"},
    p = {function() telescope.find_files({hidden = true}); end, "Files"},
    P = {
        function()
            require('telescope').extensions.frecency.frecency({
                workspace = 'CWD'
            });
        end,
        "Recent Files"
    },
    t = {
        name = "terminal",
        t = {":FloatermToggle<CR>", "Toggle terminal"},
        l = {":FloatermNext<CR>", "Next terminal"},
        h = {":FloatermPrev<CR>", "Previous terminal"}
    },
    u = {function() require"terminal".toggle(2) end, "Tests terminal"},
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
    ['<leader>'] = {
        function() require('legendary').find() end,
        "Search everything"
    }
}

wk.register(wk_mappings, {prefix = "<leader>", nowait = true})
