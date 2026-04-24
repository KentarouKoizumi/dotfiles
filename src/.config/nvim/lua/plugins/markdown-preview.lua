return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  keys = {
    { "<leader>mo", "<Cmd>MarkdownPreview<CR>", desc = "Markdown: プレビューを開始" },
    { "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", desc = "Markdown: プレビューを開始/終了" },
    { "<leader>mP", "<Cmd>MarkdownPreviewStop<CR>", desc = "Markdown: プレビューを停止" },
  },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
