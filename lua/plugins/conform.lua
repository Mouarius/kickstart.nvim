return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format' },
      htmldjango = { 'djlint' },
      astro = { 'biome' },
    },
    formatters = {
      biome = {
        command = 'biome',
        args = { 'format', '--write', '--stdin-file-path', '$FILENAME' },
      },
    },
    log_level = vim.log.levels.DEBUG,
  },
  keys = {
    {
      '<leader>cf',
      function()
        return require('conform').format { async = true, lsp_fallback = true, lsp_format = 'last' }
      end,
      mode = '',
      desc = 'LSP: Format',
    },
  },
}
