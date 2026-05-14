return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = { enabled = true },
    notifier = { enabled = true },
    -- words = {
    --   enabled = true,
    --   debounce = 200,
    --   notify_jump = false,
    --   notify_end = true,
    --   foldopen = true,
    --   jumplist = true,
    --   modes = { "n", "i", "c" },
    -- }
  },
  keys = {
    {
      "<Leader>ff",
      function()
        Snacks.picker.files()
      end,
      mode = "n",
      desc = "検索: ファイルを探して開く",
    },
    {
      "<Leader>fg",
      function()
        Snacks.picker.grep()
      end,
      mode = "n",
      desc = "検索: プロジェクト内を文字列検索",
    },
    {
      "<Leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      mode = "n",
      desc = "検索: バッファを切り替える",
    },
    {
      "<Leader>fh",
      function()
        Snacks.picker.help()
      end,
      mode = "n",
      desc = "検索: ヘルプタグを探す",
    },
    {
      "<Leader>gg",
      function()
        Snacks.lazygit()
      end,
      mode = "n",
      desc = "Git: lazygit を開く",
    },
  },
}
