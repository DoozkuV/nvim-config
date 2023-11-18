return {
  {
    "windwp/nvim-autopairs",
    -- Optional dependency
    event = 'InsertEnter',
    config = function()
      require("nvim-autopairs").setup {
        disable_filetype = { "sh", "zsh", "TeleScopePrompt", "spectre_panel", "norg" },
      }
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
}
