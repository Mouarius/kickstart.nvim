return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  opts = {
    transparent_mode = true,
    constrast = "soft"
  },
  config = function(_, opts)
    require('gruvbox').setup(opts)
    -- vim.cmd('colorscheme gruvbox')
  end,
}
