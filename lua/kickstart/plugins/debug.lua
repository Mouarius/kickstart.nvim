return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    'theHamsta/nvim-dap-virtual-text',
    {

      'mfussenegger/nvim-dap-python',
      enabled = function()
        return require('dap.config').handler_active['python']
      end,
    },
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<leader>dc', dap.continue, desc = 'Debug: Start/Continue' },
      { '<leader>di', dap.step_into, desc = 'Debug: Step Into' },
      { '<leader>dn', dap.step_over, desc = 'Debug: Step Over' },
      { '<leader>do', dap.step_out, desc = 'Debug: Step Out' },
      { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>dB',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      {
        '<leader>lp',
        function()
          require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
        end,
        desc = 'Debug: Set Logpoint',
      },
      {
        '<Leader>dr',
        function()
          require('dap').repl.open()
        end,
        desc = 'Debug: Open REPL',
      },
      {
        '<Leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Debug: Run Last',
      },
      {
        '<Leader>dh',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Debug: Hover',
      },
      {
        '<Leader>dp',
        function()
          require('dap.ui.widgets').preview()
        end,
        desc = 'Debug: Preview',
      },
      {
        '<Leader>dF',
        function()
          local widgets = require 'dap.ui.widgets'
          widgets.centered_float(widgets.frames)
        end,
        desc = 'Debug: Frames',
      },
      {
        '<Leader>dS',
        function()
          local widgets = require 'dap.ui.widgets'
          widgets.centered_float(widgets.scopes)
        end,
        desc = 'Debug: Scopes',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<leader>dls', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local dap_config = require 'dap.config'
    local utils = require 'utils'

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = '', linehl = '', numhl = '' })

    require('mason').setup()
    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,
      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = dap_config.mason_ensure_installed,
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- -- Set icons to characters that are more likely to work in every terminal.
      -- --    Feel free to remove or use ones that you like more! :)
      -- --    Don't feel like these are good choices.
      -- icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      -- controls = {
      --   icons = {
      --     pause = '⏸',
      --     play = '▶',
      --     step_into = '⏎',
      --     step_over = '⏭',
      --     step_out = '⏮',
      --     step_back = 'b',
      --     run_last = '▶▶',
      --     terminate = '⏹',
      --     disconnect = '⏏',
      --   },
      -- },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    if dap_config.handler_active.python then
      require('dap.python').setup()
    end
  end,
}
