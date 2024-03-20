return {
  {
    "windwp/nvim-autopairs",
    -- Optional dependency
    event = 'InsertEnter',
    config = function()
      local npairs = require("nvim-autopairs")

      npairs.setup {
        disable_filetype = { "sh", "zsh", "TeleScopePrompt", "spectre_panel", "norg" },
      }
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
      -- Now we will define custom rules
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      -- MARKDOWN RULES
      npairs.add_rules({
        Rule("*", "*", "markdown"):with_move(cond.done()),
        Rule("**", "*", "markdown"):with_move(cond.not_after_text("*"))
      })

      -- LISP RULES
      local lisp_filetypes = { "scheme", "clojure", "racket", "lisp" }
      npairs.get_rules("'")[1].not_filetypes = lisp_filetypes
      npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))
    end,
  },
}
