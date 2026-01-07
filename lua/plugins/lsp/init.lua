return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'mason-org/mason.nvim', opts = {} }, -- NOTE: Must be loaded before dependants
    {
      'zapling/mason-lock.nvim',
      init = function()
        require('mason-lock').setup {
          lockfile_path = vim.fn.stdpath 'config' .. '/mason-lock.json', -- (default)
        }
      end,
    },
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
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = true })
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

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- joshuadavidthomas/django-language-server
    vim.lsp.config('djls', {
      init_options = {
        django_settings_module = 'mysite.settings',
        venv_path = vim.fn.getcwd() .. '/.venv',
        -- env_path = '/Users/mariusmenault/dev/greenday/.venv/bin/python',
      },
      root_markers = { 'manage.py' },
    })
    vim.lsp.enable 'djls'

    vim.lsp.config('basedpyright', {
      root_markers = { 'manage.py' },
      settings = {
        basedpyright = {
          typeCheckingMode = 'off',
          disableOrganizeImports = true,
          analysis = {
            autoSearchPaths = false,
            diagnosticMode = 'openFilesOnly',
          },
        },
      },
    })

    -- vim.lsp.config('ty', {
    --   root_markers = { 'manage.py' },
    --   settings = {
    --     ty = {
    --       disableLanguageServices = true
    --     },
    --   },
    -- })
    -- vim.lsp.enable 'ty'

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

    require('mason-lspconfig').setup {
      ensure_installed = {
        'lua_ls',
        -- 'ty',
        'basedpyright',
        'cssls',
        'jsonls',
        'ast_grep',
        'bashls',
        'ruff',
        'ts_ls',
      },
      automatic_enable = true,
    }
  end,
}
