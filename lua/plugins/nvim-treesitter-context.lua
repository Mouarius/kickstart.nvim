return {
  'nvim-treesitter/nvim-treesitter-context',
  event = { 'BufReadPost' },
  version = '*',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  enabled = true,
  opts = { mode = 'cursor', max_lines = 3 },
}
