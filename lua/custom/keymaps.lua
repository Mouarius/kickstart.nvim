-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Options keymap
vim.keymap.set('n', '<leader>ow', function()
  ---@diagnostic disable-next-line: undefined-field
  vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = 'Toggle line wrapping' })

vim.keymap.set('n', '<leader>orn', function()
  ---@diagnostic disable-next-line: undefined-field
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end)

-- Navigation keymaps
vim.keymap.set('n', 'L', '$', { desc = 'Go to end of line' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

local function hide_diagnostics()
  vim.diagnostic.config { -- https://neovim.io/doc/user/diagnostic.html
    virtual_text = false,
    signs = false,
    underline = false,
  }
end

local function show_diagnostics()
  vim.diagnostic.config {
    virtual_text = false,
    signs = true,
    underline = true,
  }
end
vim.keymap.set('n', '<leader>dh', hide_diagnostics, { desc = '[D]iagnostics [H]idden' })
vim.keymap.set('n', '<leader>dv', show_diagnostics, { desc = '[D]iagnostics [V]isible' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })

vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<cr>', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>sh', '<cmd>split<cr>', { desc = 'Split horizontally' })
vim.keymap.set('n', '<leader>sx', '<cmd>close<cr>', { desc = 'Split close' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Split equal size' })
-- tabs
vim.keymap.set('n', '<leader>tc', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabnext<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', '<leader>tp', '<cmd>tabprev<CR>', { desc = 'Go to previous tab' })

vim.keymap.set('n', '<leader>yf', function()
  local file_path = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg('+', file_path)
  vim.notify 'Copied file path to clipboard!'
end, { desc = '[y]ank file [f]ull path' })

vim.keymap.set('n', '<leader>yr', function()
  local file_path = vim.api.nvim_buf_get_name(0)
  local cwd = vim.fn.getcwd()
  local relative_path = "~" .. string.sub(file_path, string.len(cwd) + 1)

  vim.fn.setreg('+', relative_path)
  vim.notify 'Copied file path to clipboard!'
end, { desc = '[y]ank file [r]elative path' })

vim.keymap.set('n', '<leader>yn', function()
  local file_name = vim.fn.expand '%:t'
  vim.fn.setreg('+', file_name)
  vim.notify 'Copied file name to clipboard!'
end, { desc = '[y]ank file [n]ame' })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

vim.keymap.set('n', '<C-a>', 'GVgg', { desc = 'Select the whole file' })

-- X
vim.keymap.set('x', '<leader>p', "_dP'", { desc = 'Paste not deleted' })

-- V
vim.keymap.set('v', '>', '>gv', { desc = 'Indent selection' })
vim.keymap.set('v', '<', '<gv', { desc = 'Deindent selection' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
