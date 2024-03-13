return {
  -- NOTE: Do not lazy-load this plugin - it is already lazy loaded
  {
    'lervag/vimtex',
    lazy = false,
    config = function()
      vim.g.vimtex_enabled = 1
      -- Set zathura as the default method of viewing files
      vim.g.vimtex_view_method = 'zathura'
    end
  }
}
