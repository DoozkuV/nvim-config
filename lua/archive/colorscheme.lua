return {
  -- Theme inspired by Atom
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  opts = {
    transparent_mode = true,
  },
  config = function()
    vim.o.background = "dark" -- or "light" for light mode
    vim.cmd.colorscheme 'gruvbox'
  end,
  {
    "parz3val/pywal-complete.nvim",
    name = "pywal16",
    config = function()
      local pywal16 = require('pywal16')
      pywal16.setup()
    end
  },
}
