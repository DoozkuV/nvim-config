return {
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
  -- See https://github.com/catppuccin/nvim
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    transparent_background = true,
    flavour = "mocha",
  },
  config = function()
    vim.cmd.colorscheme('catppuccin')
  end,
}
