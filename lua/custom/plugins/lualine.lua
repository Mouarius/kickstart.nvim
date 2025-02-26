return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    local colors = require('catppuccin.palettes').get_palette 'mocha'
    local custom_theme = {
      normal = {
        a = { fg = colors.base, bg = colors.yellow },
        b = { fg = colors.subtext1 },
        c = { fg = colors.subtext1 },
        z = { fg = colors.yellow },
      },
      insert = {
        a = { fg = colors.base, bg = colors.green },
        z = { fg = colors.green },
      },
      visual = {
        a = { fg = colors.base, bg = colors.mauve },
        z = { fg = colors.mauve },
      },
      replace = {
        a = { fg = colors.base, bg = colors.red },
        z = { fg = colors.red },
      },

      inactive = {
        a = { fg = colors.text },
        b = { fg = colors.subtext1 },
        c = { fg = colors.subtext1 },
        z = { fg = colors.yellow },
      },
    }

    local lint_progress = function()
      local linters = require('lint').get_running()
      if #linters == 0 then
        return '󰦕'
      end
      return '󱉶  ' .. table.concat(linters, ', ')
    end
    lualine.setup {
      options = {
        theme = custom_theme,
        extensions = { 'neo-tree', 'trouble' },
        section_separators = { left = '', right = '' },
        component_separators = '',
      },
      sections = {
        lualine_a = {
          { 'mode', right_padding = 2 },
        },
        lualine_b = {
          { 'filename', file_status = false, path = 4 },
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'error' },
            diagnostics_color = { error = { fg = colors.red } },
          },
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'warn' },
            diagnostics_color = { warn = { fg = colors.yellow } },
          },
        },
        lualine_c = {
          { lint_progress },
        },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { { 'filename', path = 1 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
    }
  end,
}
