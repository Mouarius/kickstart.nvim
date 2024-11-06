return {
  'LintaoAmons/scratch.nvim',
  event = 'VeryLazy',
  config = function()
    get_scratch_file_dir = function()
      local default_dir = vim.fn.stdpath 'cache' .. '/scratch.nvim'
      local root_dir = vim.env.PWD
      local var_dir = vim.fn.finddir('var', root_dir)
      if var_dir == '' then
        return default_dir
      end
      local scracth_dir = vim.fn.finddir('scratch', var_dir)
      if scracth_dir == '' then
        vim.fn.mkdir 'scratch'
        vim.notify 'found scratch dir'
        return vim.fs.joinpath(var_dir, 'scratch')
      end
    end
    require('scratch').setup {
      scratch_file_dir = get_scratch_file_dir(),
      filetypes = { 'py', 'ts', 'js', 'sh', 'md', 'json' },
    }
  end,
  keys = {
    { '<leader>n', '<cmd>Scratch<cr>', desc = '[n]ew scratch file' },
    { '<leader>fs', '<cmd>ScratchOpenFzf<cr>', desc = '[f]ind in [s]cratch files' },
  },
}
