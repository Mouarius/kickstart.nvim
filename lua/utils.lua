local M = {}

M.is_in_greenday = function(bufnr)
  -- Get the full path of the buffer with the given bufnr
  return vim.api.nvim_buf_get_name(bufnr):match 'greenday' ~= nil
end

return M
