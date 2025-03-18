-- Displays the colors of certain RGB statements in css buffers
return {
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
