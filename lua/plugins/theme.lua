return {
  -- Base colorscheme
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

  -- Set lualine as statusline
  {
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    }
  },

  -- Displays the colors of certain RGB statements in css buffers
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup {
        css = { names = true, rgb_fn = true, hsl_fn = true, css = true, css_fn = true, },
        'javascript',
        'hyprlang',
        html = {
          mode = 'foreground',
        }
      }
    end,
  }
}
