require("config.lazy")

require("config.options")
require("config.keymaps")

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
  callback = function(args)
    local buf = args.buf

    -- 無名バッファだけ対象
    if vim.api.nvim_buf_get_name(buf) ~= "" then
      return
    end

    -- 既に filetype が付いていたら何もしない
    if vim.bo[buf].filetype ~= "" then
      return
    end

    local ft, on_detect = vim.filetype.match({ buf = buf })
    if ft then
      vim.bo[buf].filetype = ft
      if on_detect then
        on_detect(buf)
      end
    end
  end,
})
