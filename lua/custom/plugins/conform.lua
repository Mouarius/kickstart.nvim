return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { c = true, cpp = true }
    --   return {
    --     timeout_ms = 500,
    --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --   }
    -- end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = function(bufnr)
        if require('conform').get_formatter_info('ruff_format', bufnr).available then
          return { 'ruff_format' }
        else
          return { 'isort', 'black' }
        end
      end,
      astro = { 'prettierd' },
      json = { 'prettierd' },
      htmldjango = { 'djlint' },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
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
