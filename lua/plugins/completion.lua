vim.g.cmp_enabled = true
return {
  'saghen/blink.cmp',

  dependencies = 'rafamadriz/friendly-snippets',
  version = "*",

  --@module 'blink.cmp'
  --@type blink.cmp.Config
  opts = {
    -- Testing recommended default config
    keymap = { preset = 'default' },
    enabled = function()
      return vim.g.cmp_enabled
    end,

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
  opts_extend = { "sources.default" },
  keys = {
    { -- Toggle completion binding
      '<leader>tc',
      function()
        vim.g.cmp_enabled = not vim.g.cmp_enabled
        print("Completion "
          .. (vim.g.cmp_enabled == true and "enabled" or "disabled"))
      end,
      desc = 'Toggle Completion',
    }
  }
}
