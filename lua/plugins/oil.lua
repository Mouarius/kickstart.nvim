return {
  'stevearc/oil.nvim',
  dependencies = { { 'echasnovski/mini.nvim' } },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    watch_for_changes = true,
  },
  view_options = {
    show_hidden = true,
  },
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
  end,
}
