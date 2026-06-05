return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    current_line_blame = true,
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Git Hunk: 次の変更箇所へ移動" })

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Git Hunk: 前の変更箇所へ移動" })

      -- Actions
      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git Hunk: 現在の変更を stage する" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git Hunk: 現在の変更を取り消す" })

      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Git Hunk: 選択範囲の変更を stage する" })

      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Git Hunk: 選択範囲の変更を取り消す" })

      map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git Hunk: バッファ全体の変更を stage する" })
      map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git Hunk: バッファ全体の変更を取り消す" })
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git Hunk: 変更内容をプレビュー表示" })
      map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Git Hunk: 変更内容をインライン表示" })

      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Git Hunk: 現在行の blame を表示" })

      map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git Hunk: 現在ファイルの差分を開く" })

      map("n", "<leader>hc", function()
        vim.cmd("diffoff!")

        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local name = vim.api.nvim_buf_get_name(buf)

          if name:match("^gitsigns://") then
            vim.api.nvim_win_close(win, true)
          end
        end
      end, { desc = "Git Hunk: 差分を閉じる" })

      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, { desc = "Git Hunk: 直前コミットとの差分を開く" })

      map("n", "<leader>hQ", function()
        gitsigns.setqflist("all")
      end, { desc = "Git Hunk: 全変更を quickfix に送る" })
      map("n", "<leader>hq", gitsigns.setqflist, { desc = "Git Hunk: 現在バッファの変更を quickfix に送る" })

      -- Toggles
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle: 現在行の blame 表示を切り替える" })
      map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle: 単語単位の差分表示を切り替える" })

      -- Text object
      map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Git Hunk: 変更ブロックを選択" })
    end,
  },
}
