local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values
local builtin = require 'telescope.builtin'

local M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      local pieces = vim.split(prompt, '  ')
      local args = { 'rg' }
      if pieces[1] then
        table.insert(args, '-e')
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, '-g')
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim
        .iter({
          args,
          { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Multi Grep',
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end

local live_grep_class = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      local args = { 'rg' }

      table.insert(args, '-e')
      table.insert(args, 'class ' .. prompt)

      ---@diagnostic disable-next-line: deprecated
      return vim
        .iter({
          args,
          { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Grep class',
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end

local live_grep_models = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      local args = { 'rg' }

      table.insert(args, '-e')
      table.insert(args, 'class ' .. prompt)

      ---@diagnostic disable-next-line: deprecated
      return vim
        .iter({
          args,
          { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-g', '**/models/**/*.py', '-g', '**/models.py' },
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Grep models',
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end

local django_template_picker = function(opts)
  opts = opts or {}
  local line = vim.api.nvim_get_current_line()

  -- More robust regex:
  -- 1. Look for '{%'
  -- 2. Look for keywords (include, extends, etc) followed by space
  -- 3. Capture everything between the first pair of quotes found
  local full_path = line:match '{%%%s*.-%s+["\'](.-)["\']'
  if full_path then
    local filename = full_path:match '([^/]+)$' or full_path
    builtin.find_files {
      prompt_title = 'Django Template: ' .. full_path,
      search_file = filename,
      search_dir = { 'templates' },
      no_ignore = false,
    }
  else
    -- Fallback: Trigger the native 'gf' behavior
    local keys = vim.api.nvim_replace_termcodes('gf', true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
  end
end

M.setup = function()
  vim.keymap.set('n', '<leader>fg', live_multigrep)
  vim.keymap.set('n', '<leader>fc', live_grep_class)
  vim.keymap.set('n', '<leader>fm', live_grep_models)

  -- Filetype-specific Autocommand for 'gf'
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('DjangoTelescope', { clear = true }),
    pattern = { 'htmldjango' },
    callback = function()
      vim.keymap.set('n', 'gf', django_template_picker, {
        buffer = true,
        desc = 'Telescope Go-to-Template',
      })
    end,
  })
end
return M
