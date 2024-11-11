return {
  'nvim-treesitter/nvim-treesitter-context',
  event = { 'BufReadPost' },
  enabled = true,
  opts = { mode = 'cursor', max_lines = 3 },
}
