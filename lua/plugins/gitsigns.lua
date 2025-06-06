return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = function()
    return {
      on_attach = function(bufnr)
        local gs = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal { ']h', bang = true }
          end
          vim.schedule(function()
            gs.nav_hunk('next')
          end)
        end, { desc = "Jump to next git [h]unk" })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[h', bang = true }
          end
          vim.schedule(function()
            gs.nav_hunk('prev')
          end)
        end, { desc = "Jump to previous git [h]unk" })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Git: Stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Git: Reset hunk' })
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Git: Stage hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Git: Reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Git: Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Git: Undo Stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git: Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git: Preview hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end, { desc = 'Git: Blame line' })
        map('n', '<leader>A', gs.toggle_current_line_blame, { desc = 'Git: Toggle current line blame' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'Git: diff this' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end)
        map('n', '<leader>td', gs.preview_hunk_inline(), { desc = '[T]oggle git show [d]eleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    }
  end,
}
