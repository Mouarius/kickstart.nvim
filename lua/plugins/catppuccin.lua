return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
    local catppuccin = require 'catppuccin'
    catppuccin.setup {
      float = {
        solid = false,
        transparent = true,
      },
      flavor = 'mocha',
      default_integrations = true,
      transparent_background = true,
      term_colors = false,
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
        alpha = true,
        harpoon = true,
        gitsigns = true,
        cmp = true,
        mini = true,
        blink_cmp = true,
        telescope = {
          enabled = true,
        },
        noice = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        neotest = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
