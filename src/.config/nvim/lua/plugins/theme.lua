return {
        -- {
        --         "catppuccin/nvim",
        --         name = "catppuccin",
        --         priority = 1000,
        --         config = function()
        --                 require("catppuccin").setup({
        --                         flavour = "frappe", -- latte, frappe, macchiato, mocha
        --                 })
        --                 vim.cmd.colorscheme("catppuccin-nvim")
        --         end,
        -- },
        -- {
        --         "EdenEast/nightfox.nvim",
        --         priority = 1000,
        --         config = function()
        --                 vim.cmd.colorscheme("carbonfox")
        --         end,
        -- },
        -- {
        --         "folke/tokyonight.nvim",
        --         lazy = false,
        --         priority = 1000,
        --         opts = {},
        --         config = function()
        --                 vim.cmd.colorscheme("tokyonight-night")
        --         end,
        -- },
        {
                "olimorris/onedarkpro.nvim",
                priority = 1000,
                config = function()
                        vim.cmd.colorscheme("onedark")
                end,
        }
}
