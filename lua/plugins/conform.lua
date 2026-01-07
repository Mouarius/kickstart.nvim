return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format' },
      astro = { 'biome' },
      htmldjango = { 'djangofmt' },
    },
    formatters = {
      biome = {
        command = 'biome',
        args = { 'format', '--write', '--stdin-file-path', '$FILENAME' },
      },
      djangofmt = {
        command = 'djangofmt',
        args = { '$FILENAME' },
        stdin = false,
        -- When stdin=false, use this template to generate the temporary file that gets formatted
        tmpfile_format = '.conform.$RANDOM.$FILENAME',
      },
    },
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
