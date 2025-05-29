return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format' },
      astro = { 'prettierd' },
      json = { 'prettierd' },
      htmldjango = { 'djlint' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
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
