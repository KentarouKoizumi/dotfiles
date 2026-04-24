return {
        "stevearc/conform.nvim",
        config = function()
                local function has_file(ctx, names)
                        local found = vim.fs.find(names, {
                                path = ctx.filename,
                                upward = true,
                        })
                        return #found > 0
                end

                require("conform").setup({
                        formatters = {
                                ["biome-check"] = {
                                        condition = function(_, ctx)
                                                return has_file(ctx, { "biome.json", "biome.jsonc" })
                                        end,
                                },
                                oxfmt = {
                                        condition = function(_, ctx)
                                                return has_file(ctx, {
                                                        ".oxfmtrc.json",
                                                        ".oxfmtrc.jsonc",
                                                        "oxfmt.config.ts",
                                                })
                                        end,
                                },
                        },

                        formatters_by_ft = {
                                typescript = { "biome-check", "oxfmt", stop_after_first = true },
                                javascript = { "biome-check", "oxfmt", stop_after_first = true },
                                typescriptreact = { "biome-check", "oxfmt", stop_after_first = true },
                                javascriptreact = { "biome-check", "oxfmt", stop_after_first = true },
                                vue = { "biome-check", "oxfmt", stop_after_first = true },
                                svelte = { "biome-check", "oxfmt", stop_after_first = true },
                                astro = { "biome-check", "oxfmt", stop_after_first = true },
                                json = { "biome-check", "oxfmt", stop_after_first = true },
                                jsonc = { "biome-check", "oxfmt", stop_after_first = true },
                                nix = { "nixfmt" },
                        },

                        format_on_save = {
                                timeout_ms = 500,
                                lsp_format = "fallback",
                        },
                })
        end,
}
