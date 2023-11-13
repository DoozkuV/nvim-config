-- This adds a modified modeline that should be more useful
return {
  'gelguy/wilder.nvim',
  config = function()
    local wilder = require('wilder')
    wilder.setup(
      {
        -- modes = { ':', '/', '?' },
        modes = { ':' },
        next_key = { "<Tab>", '<C-j>' },
        prev_key = { "<S-Tab>", '<C-k>' },
      }
    )
    wilder.set_option('renderer', wilder.popupmenu_renderer(
      wilder.popupmenu_border_theme({
        highlights = {
          border = 'Normal', -- highlight to use for the border
        },
        -- 'single', 'double', 'rounded' or 'solid'
        border = 'rounded',
        -- highlighter applies highlighting to the candidates
        highlighter = wilder.basic_highlighter(),
        left = { ' ', wilder.popupmenu_devicons() },
        -- Transparency
        pumblend = 20,
      })
    ))
  end
}
