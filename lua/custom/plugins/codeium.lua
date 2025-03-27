return {
  'Exafunction/codeium.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  event = "InsertEnter",
  build = "Codeium Auth",
  config = function()
    require('codeium').setup {
      enable_cmp_source = true,
      virtual_text = {
        enabled = false,
        key_bindings = {
          -- Accept the current completion.
          accept = false,
          -- Accept the next word.
          accept_word = false,
          -- Accept the next line.
          accept_line = false,
          -- Clear the virtual text.
          clear = '<C-x>',
          -- Cycle to the next completion.
          next = '<C-]>',
          -- Cycle to the previous completion.
          prev = '<C-[>',
        },
      },
    }
    vim.keymap.set('n', '<leader>oc', '<cmd>CodeiumToggle<cr>', { desc = 'Toggle Codeium extension' })
  end,
}
