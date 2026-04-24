return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>go", "<Cmd>DiffviewOpen<CR>", desc = "Git: Diffview を開く" },
    { "<leader>gc", "<Cmd>DiffviewClose<CR>", desc = "Git: Diffview を閉じる" },
    { "<leader>gf", "<Cmd>DiffviewFileHistory %<CR>", desc = "Git: 現在ファイルの履歴を表示" },
  },
}
