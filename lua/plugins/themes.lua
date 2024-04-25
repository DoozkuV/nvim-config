return {
  -- See https://github.com/catppuccin/nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = true,
    opts = {
      transparent_background = true,
      flavour = "mocha",
    },
    config = function()
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  -- Theme inspired by Atom
  -- 'ellisonleao/gruvbox.nvim',
  -- priority = 1000,
  -- opts = {
  --   transparent_mode = true,
  -- },
  -- config = function()
  --   vim.o.background = "dark" -- or "light" for light mode
  --   vim.cmd.colorscheme 'gruvbox'
  -- end,
  -- {
  --   "parz3val/pywal-complete.nvim",
  --   name = "pywal16",
  --   config = function()
  --     local pywal16 = require('pywal16')
  --     pywal16.setup()
  --   end
  -- },

}
