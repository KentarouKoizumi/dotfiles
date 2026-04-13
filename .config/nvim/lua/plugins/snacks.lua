return {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
                picker = { enabled = true },
                notifier = { enabled = true },
        },
        keys = {
                {
                        "<Leader>ff",
                        function()
                                Snacks.picker.files()
                        end,
                        mode = "n",
                        desc = "Find Files",
                },
                {
                        "<Leader>fg",
                        function()
                                Snacks.picker.grep()
                        end,
                        mode = "n",
                        desc = "Live Grep",
                },
                {
                        "<Leader>fb",
                        function()
                                Snacks.picker.buffers()
                        end,
                        mode = "n",
                        desc = "Find Buffers",
                },
                {
                        "<Leader>fh",
                        function()
                                Snacks.picker.help()
                        end,
                        mode = "n",
                        desc = "Find Help Tags",
                },
                {
                        "<Leader>gg",
                        function()
                                Snacks.lazygit()
                        end,
                        mode = "n",
                        desc = "lazygit",
                },
        },
}
