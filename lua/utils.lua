local M = {}

M.is_in_greenday = function(bufnr)
  -- Get the full path of the buffer with the given bufnr
  return vim.api.nvim_buf_get_name(bufnr):match 'greenday' ~= nil
end

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

M.get_python_path = function()
  -- 1. Check if a virtualenv is already activated in the shell
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  end

  -- 2. Fallback: Look for a local .venv folder if nothing is active
  local venv = vim.fs.find('.venv', { upward = true, stop = vim.uv.os_homedir() })[1]
  if venv then
    return venv .. '/bin/python'
  end

  -- 3. Last resort: use system python
  return vim.fn.exepath 'python3'
end

-- Helper to find the django settings module
-- (This assumes your settings are in [project_name]/settings.py)
M.get_django_settings = function()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  return project_name .. '.settings'
end

M.find_precommit_file = function()
  local Path = require 'plenary.path'
  local scan = require 'plenary.scandir'
  local precommit_paths = {
    '.pre-commit-config.yaml',
    '.pre-commit.yaml',
  }
  -- First check in current directory
  for _, filename in ipairs(precommit_paths) do
    local file_path = vim.fn.getcwd() .. '/' .. filename
    if vim.fn.filereadable(file_path) == 1 then
      return file_path
    end
  end

  -- Then check in parent directories
  local current_dir = Path:new(vim.fn.getcwd())
  while current_dir and current_dir.filename ~= '/' do
    for _, filename in ipairs(precommit_paths) do
      local file_path = current_dir.filename .. '/' .. filename
      if vim.fn.filereadable(file_path) == 1 then
        return file_path
      end
    end
    current_dir = current_dir:parent()
  end

  return nil
end

M.extract_ruff_version = function(file_path)
  local content = vim.fn.readfile(file_path)
  for _, line in ipairs(content) do
    -- Look for ruff repository reference like "repo: https://github.com/charliermarsh/ruff-pre-commit"
    if line:match 'repo:.*ruff%-pre%-commit' then
      -- Look for rev: entry in the next few lines
      for i = 1, 5 do
        if content[_ + i] and content[_ + i]:match 'rev:' then
          local version = content[_ + i]:match 'rev:%s*["\']?v?([%d%.]+)'
          if version then
            return version
          end
        end
      end
    end
  end
  return nil
end

return M
