local config = {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  keys = {
    {
      '&',
      function()
        require('neo-tree.command').execute { toggle = true, reveal = true, position = 'float' }
      end,
      desc = 'Explorer NeoTree',
    },
    {
      '<leader>eg',
      function()
        require('neo-tree.command').execute { source = 'git_status', toggle = true, position = 'float' }
      end,
      desc = 'Git explorer',
    },
    {
      '<leader>eb',
      function()
        require('neo-tree.command').execute { source = 'buffers', toggle = true, position = 'float' }
      end,
      desc = 'Buffer explorer',
    },
  },
  deactivate = function()
    vim.cmd [[Neotree close]]
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    {
      's1n7ax/nvim-window-picker',
      event = 'VeryLazy',
      version = '2.*',
      opts = {
        highlights = {
          statusline = {
            focused = {
              fg = '#f9e2af',
              bg = '#313244',
              bold = true,
            },
            unfocused = {
              fg = '#cdd6f4',
              bg = '#313244',
              bold = false,
            },
          },
        },
      },
    },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    window = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ['o'] = 'open',
        ['oc'] = 'noop',
        ['od'] = 'noop',
        ['og'] = 'noop',
        ['om'] = 'noop',
        ['on'] = 'noop',
        ['os'] = 'noop',
        ['ot'] = 'noop',
        ['O'] = 'noop',
      },
    },
    filesystem = {
      hijack_netrw_behavior = 'open_default',
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          '.DS_Store',
          '__pycache__',
        },
      },
      window = {
        mapping_options = {
          noremap = true,
          nowait = false,
        },
        mappings = {
          ['o'] = 'open',
          ['oc'] = 'noop',
          ['od'] = 'noop',
          ['og'] = 'noop',
          ['om'] = 'noop',
          ['on'] = 'noop',
          ['os'] = 'noop',
          ['ot'] = 'noop',
          ['O'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'O' } },
          ['Oc'] = { 'order_by_created', nowait = false },
          ['Od'] = { 'order_by_diagnostics', nowait = false },
          ['Og'] = { 'order_by_git_status', nowait = false },
          ['Om'] = { 'order_by_modified', nowait = false },
          ['On'] = { 'order_by_name', nowait = false },
          ['Os'] = { 'order_by_size', nowait = false },
          ['Ot'] = { 'order_by_type', nowait = false },
        },
      },
    },
  },
}
return {}
-- return config
