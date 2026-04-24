return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 200,
    spec = {
      { "<leader>c", group = "Code / LSP" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>m", group = "Markdown" },
      { "<leader>r", group = "Refactor" },
      { "<leader>t", group = "Test / Toggle" },
      { "<leader>u", group = "UI Toggle" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "which-key: 現在のバッファで使えるキーマップ一覧を表示",
    },
  },
}
