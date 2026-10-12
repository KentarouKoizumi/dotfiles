return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "davidmh/cspell.nvim",
    },
    config = function()
      local cspell = require("cspell")
      -- 作成・編集した辞書を次の診断で読み直す。
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("CspellConfigCache", { clear = true }),
        pattern = {
          "cspell.json",
          ".cspell.json",
          "cSpell.json",
          ".cSpell.json",
          ".cspell.config.json",
        },
        callback = function()
          require("cspell.helpers").clear_cache()
        end,
      })
      require("null-ls").setup({
        sources = {
          cspell.diagnostics.with({
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity.HINT
            end,
          }),
          cspell.code_actions,
        },
      })
    end,
  },
}
