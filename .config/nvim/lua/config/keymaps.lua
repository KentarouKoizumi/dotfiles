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
end, { desc = "Test: nearest" })
vim.keymap.set("n", "<leader>tf", function()
  with_neotest(function(neotest)
    neotest.run.run(vim.fn.expand("%"))
  end)
end, { desc = "Test: file" })
vim.keymap.set("n", "<leader>tl", function()
  with_neotest(function(neotest)
    neotest.run.run_last()
  end)
end, { desc = "Test: last" })
vim.keymap.set("n", "<leader>to", function()
  with_neotest(function(neotest)
    neotest.output.open({ enter = true, auto_close = true })
  end)
end, { desc = "Test: output" })
vim.keymap.set("n", "<leader>tp", function()
  with_neotest(function(neotest)
    neotest.output_panel.toggle()
  end)
end, { desc = "Test: output panel" })
vim.keymap.set("n", "<leader>ts", function()
  with_neotest(function(neotest)
    neotest.summary.toggle()
  end)
end, { desc = "Test: summary" })
