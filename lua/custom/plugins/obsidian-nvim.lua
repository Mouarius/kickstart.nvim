return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/vaults/personal',
      },
    },
    templates = {
      folder = 'Template',
    },
    daily_notes = {
      folder = 'Daily',
      template = 'Daily',
    },
  },
  config = function(_, opts)
    local obsidian = require 'obsidian'
    obsidian.setup(opts)
    -- vim.keymap.set('n', '<S-K>', '<cmd>ObsidianToggleCheckbox<cr>$a', { desc = 'Create checkbox and insert' })
  end,
  keys = {
    { '<leader>nt', '<cmd>ObsidianToday<cr>', 'Open obsidian [T]oday' },
    { '<leader>ny', '<cmd>ObsidianYesterday<cr>', 'Open obsidian [Y]esterday' },
  },
}
