return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
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
    "saghen/blink.cmp",
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        map('<leader>cn', vim.lsp.buf.rename, '[C]ode [R]ename')

        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink-cmp').get_lsp_capabilities())

    local vue_language_server_path = vim.fn.getenv 'HOME' .. '/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server'
    local ruff_path = vim.fn.getenv 'HOME' .. '/.local/share/nvim/mason/packages/ruff/venv/bin/ruff'

    local pre_commit_config = vim.fn.findfile 'pre-commit-config.yaml'

    local servers = {
      cssls = {},
      astro = {},
      volar = {
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      },
      pyright = {
        root_dir = function()
          -- Configure the root directory for my dev environment at work
          local cwd = vim.fn.getcwd()
          if string.match(cwd, 'greenday') then
            return vim.fn.getcwd() .. '/mysite'
          end
          return cwd
        end,
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
          python = {
            analysis = {
              diagnosticMode = 'openFilesOnly',
              useLibraryCodeForTypes = true,
            },
          },
          pyright = {
            disableOrganizeImports = true,
          },
        },
      },
      ruff = {
        on_attach = function(client, bufnr)
          if client.name == 'ruff' then
            client.server_capabilities.hoverProvider = false
          end
        end,
      },
      tailwindcss = {
        root_dir = function()
          local cwd = vim.fn.getcwd()
          if string.match(cwd, 'greenday') then
            return '~/dev/greenday/fronts/'
          end
          return vim.fn.getcwd()
        end,
      },
      jinja_lsp = {},
      ts_ls = {
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
              languages = { 'vue' },
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
    }

    require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
