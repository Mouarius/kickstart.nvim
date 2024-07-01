return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('trouble').setup()
    vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<CR>', { desc = 'Trouble diagnostics current file' })
    vim.keymap.set('n', '<leader>xD', '<cmd>Trouble diagnostics toggle focus=false<CR>', { desc = 'Trouble diagnostics all files' })
  end,
}
