return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

    -- Extra LSP features when editing nvim conf
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } }
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
      nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

      nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
      -- nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
      nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
      -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
      -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, 'Workspace List Folders')

      nmap('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, 'Toggle Hints')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    -- LSP SERVER CONFIGURATION
    local servers = {
      clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
      },
      gopls = {},
      pylsp = {},
      rust_analyzer = {},
      -- elixirls = {
      --   filetypes = { "elixir", "eelixir", "heex", "surface" },
      --   single_file_support = true
      -- },
      sqlls = { filetypes = { 'sql', 'mysql' } },
      bashls = { filetypes = { 'sh', 'zsh' }, },
      -- tsserver = {},
      html = { filetypes = { 'html', 'twig', 'hbs' } },

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      svelte = {},
      emmet_ls = {},
      tailwindcss = {},
      jsonls = {},
      cssls = {},
      ts_ls = {},

      zls = {},
      ruby_lsp = {},
    }

    -- Setup neovim lua configuration
    -- Disabled because of Lazydev
    -- require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end
    }

    -- Setup racket lsp server (doesn't work with mason)
    require('lspconfig').racket_langserver.setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- AUTOFORMATTING
    -- Switch for controlling whether you want autoformatting.
    --  Use :KickstartFormatToggle to toggle autoformatting on or off
    local format_is_enabled = true
    vim.api.nvim_create_user_command('KickstartFormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})
    vim.keymap.set("n", "<leader>tf", ":KickstartFormatToggle<cr>", { desc = "Toggle Formatting", silent = true })

    -- LSP Diagnostic Warnings Toggle
    local isLspDiagnosticsVisible = true
    vim.keymap.set("n", "<leader>tw", function()
      isLspDiagnosticsVisible = not isLspDiagnosticsVisible
      vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible,
      })
    end, { desc = "Toggle Warnings", silent = true })

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'kickstart-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- Tsserver usually works poorly. Sorry you work with bad languages
        -- You can remove this line if you know what you're doing :)
        if client.name == 'tsserver' then
          return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end

            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            }
          end,
        })
      end,
    })
  end,

}
