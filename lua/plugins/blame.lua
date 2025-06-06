return {
  'FabijanZulj/blame.nvim',
  config = function(opts)
    require("blame").setup(opts)
  end,
  keys = {
    { '<leader>a', '<cmd>BlameToggle window<CR>', desc = 'Toggle git blame (window)' },
  },
}
