local M = {}

local python_debugpy_path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'

function M.setup()
  local dap_python = require 'dap-python'
  local dap = require 'dap'

  dap_python.setup(python_debugpy_path)

  if python_debugpy_path then
    local manage_py_path = vim.fs.find({ 'manage.py' }, { limit = 1, type = 'file', upward = false })[1]
    local mysite_dir = vim.fs.find({ 'mysite' }, { limit = 1, type = 'directory', upward = false })[1]
    if manage_py_path then
      local config = {
        type = 'python',
        -- python = { python_path },
        -- pythonPath = function()
        --   return python_path
        -- end,
        request = 'launch',
        cwd = mysite_dir,
        test_runner = 'pytest',
        django = true,
        name = 'Django (launch)',
        program = manage_py_path,
        args = { 'runserver' },
      }
      table.insert(dap.configurations.python, config)
    end
  end
end

return M
