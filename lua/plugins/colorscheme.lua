return {

  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function(_, opts)
      require('gruvbox').setup {
        transparent_mode = true,
        constrast = 'soft',
      }
      -- vim.o.background = 'light'
      -- vim.cmd 'colorscheme gruvbox'
    end,
  },
  {
    'vague-theme/vague.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('vague').setup {
        transparent = true,
      }
      vim.cmd 'colorscheme vague'
    end,
  },
}
