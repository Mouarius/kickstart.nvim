return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }

    require('mini.surround').setup()

    require('mini.move').setup()

    require('mini.bufremove').setup()

    require('mini.statusline').setup {
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
          local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
          local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
          local filename = MiniStatusline.section_filename { trunc_width = 140 }
          local filetype = vim.bo.filetype
          local location = MiniStatusline.section_location { trunc_width = 75 }

          local lint_progress = function()
            local linters = require('lint').get_running()
            if #linters == 0 then
              return '󰦕'
            end
            return '󱉶 ' .. table.concat(linters, ', ')
          end
          local search = MiniStatusline.section_searchcount { trunc_width = 75 }

          return MiniStatusline.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { diagnostics, lsp } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { lint_progress(), filetype } },
            { hl = mode_hl, strings = { search, location } },
          }
        end,
        inactive = function()
          local filename = MiniStatusline.section_filename { trunc_width = 140 }
          return MiniStatusline.combine_groups {
            { hl = 'MiniStatuslineInactive', strings = { filename } },
          }
        end,
      },
    }

    vim.keymap.set('n', '<leader>bd', function()
      local bd = require('mini.bufremove').delete
      if vim.bo.modified then
        local choice = vim.fn.confirm('Save changes to %q?', '&Yes\n&No\n&Cancel', 'Warning')
        if choice == 1 then
          vim.cmd.write()
          bd(0)
        elseif choice == 2 then
          bd(0, true)
        end
      else
        bd(0)
      end
    end, { desc = 'Delete buffer' })
  end,
  version = false,
  event = 'VimEnter',
}
