return {
  { -- LSP Configuration & Plugins
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
      -- Completion
      'saghen/blink.cmp',
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- LSP SERVER CONFIGURATION
      local servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
        },
        gopls = {},
        pylsp = {},
        rust_analyzer = {},
        elixirls = { single_file_support = true },
        sqlls = { filetypes = { 'sql', 'mysql' } },
        bashls = { filetypes = { 'sh', 'zsh' }, },

        phpactor = { filetypes = { "php" } },
        zls = {},
        ruby_lsp = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        jsonls = {},

        -- Web dev
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        cssls = {},
        ts_ls = {},
        tailwindcss = {},
        emmet_ls = { filetypes = { "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "svelte", "typescriptreact", "vue", "htmlangular", "templ" } },

        -- Go templating language
        templ = {},
        -- Web frameworks
        svelte = {},
        astro = {},
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        automatic_enable = true,
        ensure_installed = vim.tbl_keys(servers),
      }

      -- LSP Diagnostic Warnings Toggle
      local isLspDiagnosticsVisible = true
      vim.keymap.set("n", "<leader>tw", function()
        isLspDiagnosticsVisible = not isLspDiagnosticsVisible
        vim.diagnostic.config({
          virtual_text = isLspDiagnosticsVisible,
          underline = isLspDiagnosticsVisible,
        })
      end, { desc = "Toggle Warnings", silent = true })
    end,
    keys = {
      {
        'grd',
        vim.lsp.buf.definition,
      },
    }
  },
  -- FORMATTING PLUGIN
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = vim.tbl_map(function(_)
        return { "prettierd", "prettier", stop_after_first = true }
      end, { "javascript", "javascriptreact", "typescript", "typescriptreact" }),
    },
  }
}
