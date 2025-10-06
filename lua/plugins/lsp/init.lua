return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'mason-org/mason.nvim', opts = {} }, -- NOTE: Must be loaded before dependants
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Useful status updates for LSP.
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          override_vim_notify = true,
          window = {
            winblend = 0, -- Background color opacity in the notification window
          },
        },
      },
    },
    'saghen/blink.cmp',
  },
  config = function()
    local utils = require 'utils'
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grn', vim.lsp.buf.rename, '[C]ode [R]ename')

        map('gra', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend('force', capabilities, require('blink-cmp').get_lsp_capabilities())
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- vim.lsp.config('pylsp', {
    --
    --   root_markers = { 'manage.py' },
    --   settings = {
    --     pylsp = {
    --       rope = {},
    --       plugins = {
    --         pylsp_rope = {
    --           rename = false
    --         },
    --         rope_rename = {
    --           enabled = false,
    --         },
    --         jedi = {
    --           enabled = false,
    --         },
    --         jedi_completion = {
    --           enabled = false,
    --         },
    --         jedi_definition = {
    --           enabled = false,
    --         },
    --         jedi_hover = {
    --           enabled = false,
    --         },
    --         jedi_symbols = {
    --           enabled = false,
    --         },
    --         pycodestyle = {
    --           enabled = false,
    --         },
    --         pylint = {
    --           enabled = false,
    --         },
    --       },
    --     },
    --   },
    -- })

    vim.lsp.config('pyright', {
      root_markers = { 'manage.py' },
      handlers = {
        ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
          -- In django, pyright keeps bothering me with "reportIncompatibleMethodOverride" errors with models Meta class
          -- Those lines of code filters the diagnostics with those error codes from the pyright lsp output
          local filtered_diagnostics = {}
          for _, value in ipairs(result.diagnostics) do
            if value ~= nil and value.code ~= 'reportIncompatibleVariableOverride' and value.code ~= 'reportIncompatibleMethodOverride' then
              table.insert(filtered_diagnostics, value)
            end
          end
          result.diagnostics = filtered_diagnostics
          return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
      },
      settings = {
        pyright = {
          typeCheckingMode = 'off',
          disableOrganizeImports = true,
          analysis = {
            autoSearchPaths = false,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
          },
        },
      },
    })

    vim.lsp.config('ruff', {
      on_attach = function(client, bufnr)
        if client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end
      end,
    })

    local vue_language_server_path = vim.fn.getenv 'HOME' .. '/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server'
    vim.lsp.config('ts_ls', {
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
          },
        },
      },
    })
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    })

    vim.lsp.config('volar', {
      init_options = {
        vue = {
          hybridMode = false,
        },
      },
    })

    vim.lsp.config('tailwindcss', {
      root_dir = function(bufnr, on_dir)
        if utils.is_in_greenday(bufnr) then
          local tailwind_root = vim.fn.getcwd() .. ''
          on_dir(tailwind_root)
        end
      end,
      settings = {
        tailwindCSS = {
          experimental = {
            configFile = 'fronts/lib/firebolt/src/tailwind.config.cjs',
          },
        },
      },
    })

    local servers = {
      cssls = {},
      astro = {},
      jinja_lsp = {},
    }

    local ensure_installed = vim.tbl_keys(servers or {})

    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      automatic_enable = true,
    }
  end,
}
