vim.g.format_on_save = false
return {
  -- Extra LSP features when editing nvim conf
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } }
      },
    },
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
      {
        '<leader>tf',
        function()
          vim.g.format_on_save = not vim.g.format_on_save
          vim.notify('Format on save: ' .. tostring(vim.g.format_on_save), vim.log.levels.INFO)
        end,
        mode = '',
        desc = '[T]oggle [F]ormatting on save'
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] or not vim.g.format_on_save then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = vim.tbl_extend("error",
        vim.tbl_map(function(_)
          return { "biome", "prettierd", "prettier", stop_after_first = true }
        end, { "javascript", "javascriptreact", "typescript", "typescriptreact" }),
        { python = { "ruff_format", "ruff_organize_imports" } }
      ),
    },
  }
}
