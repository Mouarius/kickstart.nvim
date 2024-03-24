return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require('mini.surround').setup()

    require('mini.bufremove').setup()

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
-- return {
--   'echasnovski/mini.bufremove',
--   keys = {
--     {
--       '<leader>bd',
--       function()
--         local bd = require('mini.bufremove').delete
--         if vim.bo.modified then
--           local choice = vim.fn.confirm('Save changes to %q?', '&Yes\n&No\n&Cancel', 'Warning')
--           if choice == 1 then
--             vim.cmd.write()
--             bd(0)
--           elseif choice == 2 then
--             bd(0, true)
--           end
--         else
--           bd(0)
--         end
--       end,
--       desc = 'Delete buffer',
--     },
--   },
-- }
