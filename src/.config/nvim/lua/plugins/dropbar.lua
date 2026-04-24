return {
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  config = function()
    local dropbar_api = require('dropbar.api')
    vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Dropbar: winbar のシンボル一覧から移動' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Dropbar: 現在のコード文脈の先頭へ移動' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Dropbar: 次のコード文脈を選択' })
  end
}
