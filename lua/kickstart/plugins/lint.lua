return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        -- python = { 'mypy' },
        htmldjango = { 'djlint' },
        -- python = { 'ruff' },
      }

      -- local eslint_d = require 'lint.linters.eslint_d'
      -- eslint_d.env = { ['ESLINT_USE_FLAT_CONFIG'] = 'false' }
      -- -- vim.notify("cwd" .. vim.fn.getcwd())
      -- eslint_d.args = vim.tbl_extend('force', {
      --   '--config',
      --   function()
      --     return vim.fn.getcwd() .. '/eslint.config.js'
      --   end,
      -- }, eslint_d.args)

      lint.linters_by_ft['clojure'] = nil
      lint.linters_by_ft['dockerfile'] = nil
      lint.linters_by_ft['inko'] = nil
      lint.linters_by_ft['janet'] = nil
      lint.linters_by_ft['json'] = nil
      lint.linters_by_ft['markdown'] = nil
      lint.linters_by_ft['rst'] = nil
      lint.linters_by_ft['ruby'] = nil
      lint.linters_by_ft['terraform'] = nil
      lint.linters_by_ft['text'] = nil
      lint.linters_by_ft['typescript'] = nil
      lint.linters_by_ft['typescriptreact'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      -- FAST LINTERS
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
