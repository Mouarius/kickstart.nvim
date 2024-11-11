local M = {}

M.load_mappings = function(mappings)
  for mode, values in pairs(mappings) do
    for keybind, mapping_info in pairs(values) do
      local action = mapping_info[1]
      local desc = mapping_info[2].desc
      vim.keymap.set(mode, keybind, action, { desc = desc })
    end
  end
end

M.get_python_venv = function()
  return vim.env.VIRTUAL_ENV
end

M.get_python_executable = function()
  local venv_path = M.get_python_venv()

  if venv_path ~= nil then
    return venv_path .. '/bin/python3'
  end

  return vim.fn.exepath("python3")
end

return M
