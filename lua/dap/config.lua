local M = {}

M.handler_active = {
  python = true,
}
M.mason_ensure_installed = {
  'python',
}

M.activate_dap = function(language, status)
  M.handler_active[language] = status
  M.update_mason_ensure_installed()
end

return M
