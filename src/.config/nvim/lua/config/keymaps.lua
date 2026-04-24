vim.keymap.set("i", "jj", "<Esc>", {
  noremap = true,
  silent = true,
  desc = "Insert: Escape",
})

-- neotest
local function with_neotest(fn)
  local ok_lazy, lazy = pcall(require, "lazy")
  if ok_lazy then
    lazy.load({ plugins = { "neotest" } })
  end

  local ok, neotest = pcall(require, "neotest")
  if not ok then
    vim.notify("neotest is not available", vim.log.levels.WARN)
    return
  end
  fn(neotest)
end

vim.keymap.set("n", "<leader>tn", function()
  with_neotest(function(neotest)
    neotest.run.run()
  end)
end, { desc = "テスト: カーソル位置のテストを実行" })
vim.keymap.set("n", "<leader>tf", function()
  with_neotest(function(neotest)
    neotest.run.run(vim.fn.expand("%"))
  end)
end, { desc = "テスト: 現在ファイルのテストを実行" })
vim.keymap.set("n", "<leader>tl", function()
  with_neotest(function(neotest)
    neotest.run.run_last()
  end)
end, { desc = "テスト: 最後に実行したテストを再実行" })
vim.keymap.set("n", "<leader>to", function()
  with_neotest(function(neotest)
    neotest.output.open({ enter = true, auto_close = true })
  end)
end, { desc = "テスト: 直近実行の出力を開く" })
vim.keymap.set("n", "<leader>tp", function()
  with_neotest(function(neotest)
    neotest.output_panel.toggle()
  end)
end, { desc = "テスト: 出力パネルを開閉" })
vim.keymap.set("n", "<leader>ts", function()
  with_neotest(function(neotest)
    neotest.summary.toggle()
  end)
end, { desc = "テスト: サマリーウィンドウを開閉" })
