return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format' },
      astro = { 'prettierd' },
      json = { 'prettierd' },
      htmldjango = { 'djangofmt' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
    },
    formatters = {
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
