local M = {}

local function unique_insert(list, value)
  for _, item in ipairs(list) do
    if item == value then
      return
    end
  end
  list[#list + 1] = value
end

function M.setup()
  local group = vim.api.nvim_create_augroup("ConformStatus", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    callback = function(args)
      vim.b[args.buf].conform_collect_on_save = true
      vim.b[args.buf].conform_run_on_save = {}
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "ConformFormatPre",
    callback = function(args)
      local buf = vim.api.nvim_get_current_buf()
      if not vim.b[buf].conform_collect_on_save then
        return
      end

      local formatter = args.data and args.data.formatter and args.data.formatter.name
      if not formatter or formatter == "" then
        return
      end

      local run = vim.b[buf].conform_run_on_save
      if type(run) ~= "table" then
        run = {}
        vim.b[buf].conform_run_on_save = run
      end
      unique_insert(run, formatter)
    end,
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    callback = function(args)
      local run = vim.b[args.buf].conform_run_on_save
      if type(run) == "table" and #run > 0 then
        vim.b[args.buf].conform_last_on_save = table.concat(run, ",")
      end

      vim.b[args.buf].conform_collect_on_save = false
      vim.b[args.buf].conform_run_on_save = nil
      vim.cmd.redrawstatus()
    end,
  })
end

function M.status()
  local value = vim.b.conform_last_on_save
  if not value or value == "" then
    return ""
  end
  return "fmt:" .. value
end

return M
