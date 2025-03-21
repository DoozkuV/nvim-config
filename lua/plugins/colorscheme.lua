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

}
