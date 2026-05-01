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
                                "docker_compose_language_service",
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
                                workspace = {
                                        didChangeWatchedFiles = {
                                                dynamicRegistration = true,
                                        },
                                },
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
                                        local function map(mode, lhs, rhs, desc)
                                                vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, {
                                                        desc = desc,
                                                }))
                                        end

                                        -- Snacks の picker を使うと候補一覧つきで飛べる
                                        map("n", "gd", function()
                                                Snacks.picker.lsp_definitions()
                                        end, "LSP: 定義を一覧表示")

                                        map("n", "gr", function()
                                                Snacks.picker.lsp_references()
                                        end, "LSP: 参照箇所を一覧表示")

                                        map("n", "gI", function()
                                                Snacks.picker.lsp_implementations()
                                        end, "LSP: 実装を一覧表示")

                                        map("n", "gy", function()
                                                Snacks.picker.lsp_type_definitions()
                                        end, "LSP: 型定義を一覧表示")

                                        -- これは単純ジャンプのままで十分
                                        map("n", "gD", vim.lsp.buf.declaration, "LSP: 宣言へ移動")

                                        -- これは標準 LSP のままでOK
                                        map("n", "K", vim.lsp.buf.hover, "LSP: ホバー情報を表示")
                                        map("n", "gK", vim.lsp.buf.signature_help, "LSP: シグネチャヘルプを表示")
                                        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: シンボル名を変更")
                                        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: コードアクションを表示")

                                        -- diagnostics
                                        map("n", "[d", vim.diagnostic.goto_prev, "診断: 前の項目へ移動")
                                        map("n", "]d", vim.diagnostic.goto_next, "診断: 次の項目へ移動")
                                        map("n", "<leader>e", vim.diagnostic.open_float, "診断: カーソル位置の詳細を表示")
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
                        vim.lsp.enable("docker_compose_language_service")
                        vim.lsp.enable("oxlint")
                        vim.lsp.enable("oxfmt")
                end,
        },
}
