return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/neotest-python',
    'marilari88/neotest-vitest',
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-vitest' {},
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
      },
    }

    vim.keymap.set('n', '<leader>Tn', '<cmd>lua require("neotest").run.run()<CR>', { desc = 'Run nearest test' })
    vim.keymap.set('n', '<leader>Tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { desc = 'Run test file' })
    vim.keymap.set('n', '<leader>Tl', function()
      require('neotest').run.run_last()
    end, { desc = 'Run last test' })
    vim.keymap.set('n', '<leader>Tdl', function()
      require('neotest').run.run_last { strategy = 'dap' }
    end, { desc = 'Run debug last test' })

    vim.keymap.set('n', '<leader>Tdn', '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>', { desc = 'Run debug nearest test' })
    vim.keymap.set('n', '<leader>Tdf', '<cmd>lua require("neotest").run.run({strategy = "dap", vim.fn.expand("%")})<CR>', { desc = 'Run debug test file' })

    vim.keymap.set('n', '<leader>Ts', '<cmd>lua require("neotest").summary.toggle()<CR>', { desc = 'Toggle test summary' })
    vim.keymap.set('n', '<leader>Tp', '<cmd>lua require("neotest").output_panel.toggle()<CR>', { desc = 'Toggle test panel' })

    vim.keymap.set('n', '<leader>Tm', '<cmd>lua require("neotest").summary.run_marked()<CR>', { desc = 'Run marked tests' })
  end,
}
