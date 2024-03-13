return {
  -- NOTE: Do not lazy-load this plugin - it is already lazy loaded
  {
    'lervag/vimtex',
    lazy = false,
    config = function()
      -- Set zathura as the default method of viewing files
      vim.g.vimtex_enabled = 1
      vim.g.vimtex_view_method = 'zathura'
    end
  }
}
