-- Conjure enables REPL like functionality in NVIM, like Emacs
return {
  "Olical/conjure",
  ft = { "clojure", "fennel", "lua", "racket" },
  cmd = { "ConjureSchool" },
  enabled = false,
  -- cmp integration
  dependencies = {
    {
      "PaterJason/cmp-conjure",
      config = function()
        local cmp = require("cmp")
        local config = cmp.get_config()
        table.insert(config.sources, {
          name = "buffer",
          option = {
            sources = {
              { name = "conjure" },
            },
          },
        })
        cmp.setup(config)
      end,
    },
  },
  config = function(_, opts)
    require("conjure.main").main()
    require("conjure.mapping")["on-filetype"]()
  end,
  -- Set configuration options here
  init = function()
    -- Documentation prefix
    vim.g["conjure#mapping#doc_word"] = "<C-k>"
  end
}
