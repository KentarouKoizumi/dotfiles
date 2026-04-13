return {
        {
                "mason-org/mason.nvim",
                lazy = false,
                opts = {},
        },
        {
                "mason-org/mason-lspconfig.nvim",
                dependencies = {
                        "mason-org/mason.nvim",
                        "neovim/nvim-lspconfig",
                },
                opts = {
                        ensure_installed = {
                                "lua_ls",
                                "oxlint",
                                "oxfmt",
                                "ts_ls",
                                "tailwindcss",
                                "csharp_ls",
                        },
                        automatic_enable = true,
                },
        },
        {
                "neovim/nvim-lspconfig",
                dependencies = {
                        "saghen/blink.cmp"
                },
                config = function()
                        local capabilities = vim.lsp.protocol.make_client_capabilities()
                        capabilities = vim.tbl_deep_extend("force", capabilities,
                                require("blink.cmp").get_lsp_capabilities({}, false))
                        capabilities = vim.tbl_deep_extend("force", capabilities, {
                                textDocument = {
                                        foldingRange = {
                                                dynamicRegistration = false,
                                                lineFoldingOnly = true,
                                        },
                                },
                        })

                        vim.api.nvim_create_autocmd("LspAttach", {
                                callback = function(args)
                                        local opts = { buffer = args.buf, silent = true }

                                        -- Snacks の picker を使うと候補一覧つきで飛べる
                                        vim.keymap.set("n", "gd", function()
                                                Snacks.picker.lsp_definitions()
                                        end, opts)

                                        vim.keymap.set("n", "gr", function()
                                                Snacks.picker.lsp_references()
                                        end, opts)

                                        vim.keymap.set("n", "gI", function()
                                                Snacks.picker.lsp_implementations()
                                        end, opts)

                                        vim.keymap.set("n", "gy", function()
                                                Snacks.picker.lsp_type_definitions()
                                        end, opts)

                                        -- これは単純ジャンプのままで十分
                                        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                                        -- これは標準 LSP のままでOK
                                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                                        vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
                                        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                                        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                                        -- diagnostics
                                        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                                        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                                        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                                end,
                        })

                        vim.diagnostic.config({
                                underline = true,
                                update_in_insert = false,
                                virtual_text = {
                                        spacing = 4,
                                        source = "if_many",
                                        prefix = "●",
                                },
                                severity_sort = true,
                        })

                        vim.lsp.config("lua_ls", {
                                capabilities = capabilities,
                                settings = {
                                        Lua = {
                                                diagnostics = {
                                                        globals = { "vim" },
                                                },
                                                workspace = {
                                                        checkThirdParty = false,
                                                },
                                                completion = {
                                                        callSnippet = "Replace",
                                                },
                                                hint = {
                                                        enable = true,
                                                },
                                        },
                                },
                        })

                        vim.lsp.config("ts_ls", {
                                capabilities = capabilities,
                        })

                        vim.lsp.config("tailwindcss", {
                                capabilities = capabilities,
                        })

                        vim.lsp.config("csharp_ls", {
                                capabilities = capabilities,
                                root_markers = {
                                        "*.sln",
                                        "*.slnx",
                                        "*.csproj",
                                        ".git",
                                },
                        })

                        vim.lsp.config("oxlint", {
                                capabilities = capabilities,
                                settings = {
                                        run = "onSave",
                                },
                        })

                        vim.lsp.enable("lua_ls")
                        vim.lsp.enable("ts_ls")
                        vim.lsp.enable("tailwindcss")
                        vim.lsp.enable("csharp_ls")
                        vim.lsp.enable("oxlint")
                        vim.lsp.enable("oxfmt")
                end,
        },
}
