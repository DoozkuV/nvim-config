return {
  "mhartington/formatter.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    require("formatter").setup {
      logging = true,

      log_level = vim.log.levels.WARN,

      filetype = {
        javascript = {
          require('formatter.filetypes.javascript').prettier,
        },
        typescript = {
          require('formatter.filetypes.typescript').prettier,
        },
        javascriptreact = {
          require('formatter.filetypes.javascriptreact').prettier,
        },
        typescriptreact = {
          require('formatter.filetypes.typescriptreact').prettier,
        },
      }
    }
  end,
  -- opts = {
  --   logging = true,
  --
  --   log_level = vim.log.levels.WARN,
  --
  --   filetype = {
  --     javascript = {
  --       require('formatter.filetypes.javascript').prettier,
  --     },
  --     typescript = {
  --       require('formatter.filetypes.typescript').prettier,
  --     },
  --     javascriptreact = {
  --       require('formatter.filetypes.javascriptreact').prettier,
  --     },
  --     typescriptreact = {
  --       require('formatter.filetypes.typescriptreact').prettier,
  --     },
  --   }
  -- }
}
