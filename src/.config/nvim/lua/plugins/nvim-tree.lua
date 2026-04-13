return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  keys = {
    { "<C-h>", "<Cmd>NvimTreeFocus<CR>", desc = "ファイルツリーを開く" },
    { "<C-d>", "<Cmd>NvimTreeToggle<CR>", desc = "ファイルツリーの表示/非表示" },
  },

  init = function()
    -- ディレクトリを開いて起動したら nvim-tree を自動で開く
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        local directory = vim.fn.isdirectory(data.file) == 1
        if not directory then
          return
        end

        -- ツリーを開く
        require("nvim-tree.api").tree.open()
      end,
    })
  end,

  opts = {
    renderer = {
      icons = {
        git_placement = "before"
      }
    },
    filters = {
      git_ignored = false,
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      api.map.on_attach.default(bufnr)

      vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
    end,
  },
}
