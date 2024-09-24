-- [[ Configure and install plugins ]]
require('lazy').setup({
  spec = {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    'christoomey/vim-tmux-navigator', -- Integration with tmux panes
    { import = 'custom.plugins' },

    require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    require 'kickstart.plugins.lint',
  },
  install = {
    colorscheme = { 'catppuccin' },
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
