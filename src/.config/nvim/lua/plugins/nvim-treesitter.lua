return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      local parsers = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "c_sharp",
        "json",
        "yaml",
        "toml",
      }

      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "python",
          "cs",
          "json",
          "yaml",
          "toml",
        },
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)
          if not ok then
            return
          end

          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldlevel = 99
          vim.wo.foldcolumn = "1"
          vim.opt.fillchars = {
            foldopen = "",
            foldclose = "",
            fold = " ",
            foldsep = " ",
            foldinner = " ",
          }
        end,
      })
    end,
  },
}
