return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  keys = {
    { "<C-h>", "<Cmd>NvimTreeFocus<CR>", desc = "ファイルツリー: フォーカスを移す" },
    { "<C-d>", "<Cmd>NvimTreeToggle<CR>", desc = "ファイルツリー: 開閉を切り替える" },
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
    -- LSP / vim.diagnostic のエラー・警告を nvim-tree に表示
    diagnostics = {
      enable = true,

      -- ディレクトリにも子要素の診断情報を表示
      show_on_dirs = true,

      -- 開いているディレクトリにも表示
      show_on_open_dirs = true,

      -- 表示する severity の範囲
      severity = {
        min = vim.diagnostic.severity.WARN,
        max = vim.diagnostic.severity.ERROR,
      },

      -- 好みで変更可能
      icons = {
        error = "",
        warning = "",
        info = "",
        hint = "󰌵",
      },
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

      vim.keymap.set("n", "l", api.node.open.edit, opts("ファイルまたはディレクトリを開く"))
    end,
  },
}
