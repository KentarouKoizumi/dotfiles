return {
        "nvim-neotest/neotest",
        dependencies = {
                "nvim-neotest/nvim-nio",
                "nvim-lua/plenary.nvim",
                "antoinemadec/FixCursorHold.nvim",
                "nvim-treesitter/nvim-treesitter",
                "Issafalcon/neotest-dotnet",
        },
        config = function()
                local dotnet = require("neotest-dotnet")({})
                local dotnet_build_spec = dotnet.build_spec
                local dotnet_results = dotnet.results

                -- Work around neotest-dotnet returning an empty spec table.
                -- neotest expects nil here to fall back to per-node execution.
                dotnet.build_spec = function(args)
                        local specs = dotnet_build_spec(args)
                        if type(specs) == "table" and next(specs) == nil then
                                return nil
                        end
                        return specs
                end

                -- Guard against adapter crashes when context is unexpectedly missing.
                dotnet.results = function(spec, process_result, tree)
                        if not spec or not spec.context or not spec.context.results_path then
                                return {}
                        end
                        return dotnet_results(spec, process_result, tree)
                end

                require("neotest").setup({
                        adapters = {
                                dotnet,
                        },
                })
        end,
}
