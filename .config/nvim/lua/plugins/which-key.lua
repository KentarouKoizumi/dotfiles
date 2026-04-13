return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 200,
    spec = {
      { "<leader>f", group = "Find" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>t", group = "Toggle" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
