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
    gh = {
      -- your gh configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    picker = {
      sources = {
        gh_issue = {
          -- your gh_issue picker configuration comes here
          -- or leave it empty to use the default settings
        },
        gh_pr = {
          -- your gh_pr picker configuration comes here
          -- or leave it empty to use the default settings
        }
      }
    },
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
    { "<leader>gi", function() Snacks.picker.gh_issue() end,                  desc = "GitHub Issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gp", function() Snacks.picker.gh_pr() end,                     desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end,    desc = "GitHub Pull Requests (all)" },
  },
}
