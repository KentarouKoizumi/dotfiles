return {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
                local function lsp_status()
                        local clients = vim.lsp.get_clients({ bufnr = 0 })
                        if #clients == 0 then
                                return ""
                        end

                        local names = {}
                        for _, client in ipairs(clients) do
                                names[#names + 1] = client.name
                        end

                        local progress = vim.lsp.status()
                        if progress and progress ~= "" then
                                return " " .. table.concat(names, ", ") .. " | " .. progress
                        end

                        return " " .. table.concat(names, ", ")
                end

                return {
                        options = {
                                theme = "auto",
                                globalstatus = true,
                        },
                        sections = {
                                lualine_a = { "mode" },
                                lualine_b = { "branch", "diff" },
                                lualine_c = { "filename" },
                                lualine_x = {
                                        {
                                                "diagnostics",
                                                sources = { "nvim_diagnostic" },
                                        },
                                        lsp_status,
                                        require("config.conform_status").status,
                                        "encoding",
                                        "fileformat",
                                        "filetype",
                                },
                                lualine_y = { "progress" },
                                lualine_z = { "location" },
                        },
                }
        end,
}
