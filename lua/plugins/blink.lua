return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'saghen/blink.compat',
      version = '*',
    },
    'Exafunction/windsurf.nvim',
  },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono',
      kind_icons = { ['codeium'] = '󰚩' },
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      documentation = {
        auto_show = false,
      },
      menu = {
        draw = {
          padding = { 0, 1 }, -- padding only on right side
          components = {
            kind_icon = {
              text = function(ctx)
                return ' ' .. ctx.kind_icon .. ctx.icon_gap
              end,
            },
          },
        },
      },
    },
    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = function()
        if vim.bo.filetype == 'oil' then
          return { 'lsp', 'path', 'buffer' }
        end
        return { 'lsp', 'lazydev', 'path', 'snippets', 'buffer', 'codeium' }
      end,
      providers = {
        codeium = {
          name = 'codeium',
          -- module = 'blink.compat.source',
          module = 'codeium.blink',
          async = true,
          -- score_offset = 99,
          transform_items = function(ctx, items)
            for _, item in ipairs(items) do
              item.kind_icon = '󰚩'
              item.kind_name = 'codeium'
            end
            return items
          end,
        },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },

  config = function(_, opts)
    local blink_cmp = require 'blink-cmp'
    blink_cmp.setup(opts)

    vim.keymap.set({ 'i', 's' }, '<C-l>', function()
      blink_cmp.snippet_forward()
    end)
  end,
}
