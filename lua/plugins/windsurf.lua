return {
  'Exafunction/windsurf.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = 'BufEnter',
  build = 'Codeium Auth',
  config = function()

    vim.g.codeium_log_file = "~/.cache/nvim/codeium/codeium.log"
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
