return {
  event = 'BufEnter *.astro',
  'wuelnerdotexe/vim-astro',
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
