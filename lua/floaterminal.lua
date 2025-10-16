local M = {}

local state = {
  floating = {
    win = -1,
    buf = -1,
  },
}
-- Function to open a floating terminal
M.create_floating_window = function(opts)
  opts = opts or {}
  -- Get editor dimensions
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate starting position to center the window
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  }

  local buf = nil

  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { win = win, buf = buf }

  -- -- Optional: Set up a keybinding to close the terminal with Escape in normal mode
  -- vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { noremap = true, silent = true })
end

M.toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = M.create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.term()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end
-- Create the command
vim.api.nvim_create_user_command('Floaterminal', M.toggle_terminal, {})

-- Keymaps
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")
vim.keymap.set({"t", "n"}, "<leader>tt", M.toggle_terminal)

return M
