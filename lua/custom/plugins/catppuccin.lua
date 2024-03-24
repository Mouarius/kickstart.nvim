return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
    local catppuccin = require 'catppuccin'
    catppuccin.setup {
      flavor = 'mocha',
      transparent_background = false,
      integrations = {
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        cmp = true,
        mini = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        nvimtree = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
