return {
  'joshuadavidthomas/django-language-server',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = function(plugin)
    -- vim.env.DJANGO_SETTINGS_MODULE = 'mysite.settings'
    --
    -- vim.opt.rtp:append(plugin.dir .. '/editors/nvim')
    -- require('djls').setup {}
  end,
}
