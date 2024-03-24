return {
  'ThePrimeagen/harpoon',
  keys = function()
    return {
      {
        '<leader>mm',
        require('harpoon.mark').add_file,
        desc = 'Mark file with harpoon',
        silent = true,
      },
      {
        '<leader>mn',
        require('harpoon.ui').nav_next,
        desc = 'Goto next harpoon mark',
        silent = true,
      },
      {
        '<leader>mp',
        require('harpoon.ui').nav_prev,
        desc = 'Goto prev harpoon mark',
        silent = true,
      },
      {
        '<leader>ml',
        require('harpoon.ui').toggle_quick_menu,
        desc = 'Toggle harpoon menu',
        silent = true,
      },
    }
  end,
}
