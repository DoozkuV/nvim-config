return {
  'saghen/blink.cmp',

  dependencies = 'rafamadriz/friendly-snippets',
  version = "*",

  --@module 'blink.cmp'
  --@type blink.cmp.Config
  opts = {
    -- Testing recommended default config
    keymap = { preset = 'default' },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    sources = {
      -- See if lazydev works here
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" }
}
