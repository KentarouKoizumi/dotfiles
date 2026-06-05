vim.api.nvim_create_user_command("FormatJson", function()
  vim.cmd("%!jq .")
end, {
  desc = "Format current buffer with jq",
})

vim.api.nvim_create_user_command("OpenHtml", function()
  local path = vim.fn.expand("%:p")
  if path == "" then
    vim.notify("No file to open", vim.log.levels.WARN)
    return
  end

  if vim.fn.executable("xdg-open") == 0 then
    vim.notify("xdg-open is not available", vim.log.levels.ERROR)
    return
  end

  vim.fn.jobstart({ "xdg-open", path }, { detach = true })
end, {
  desc = "Open current HTML file with xdg-open",
})
