-- Hook onto files for fast access
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",                        -- use the modern version
  dependencies = { "nvim-lua/plenary.nvim" }, -- "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})
  end,

  keys = {
    {
      '<leader>a',
      function() require("harpoon"):list():add() end,
      desc = 'Add Mark'
    },
    {
      '<leader>q',
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Quick Menu'
    },
    {
      '<C-s>',
      function() require("harpoon"):list():select(1) end,
      desc = 'Harpoon [1]'
    },
    {
      '<C-f>',
      function() require("harpoon"):list():select(2) end,
      desc = 'Harpoon [2]'
    },
    {
      '<C-n>',
      function() require("harpoon"):list():select(3) end,
      desc = 'Harpoon [3]'
    },
    {
      '<C-p>',
      function() require("harpoon"):list():select(4) end,
      desc = 'Harpoon [4]'
    },
    {
      '<C-M-p>',
      function() require("harpoon"):list():prev() end,
      desc = "Harpoon Prev"
    },
    {
      '<C-M-n>',
      function() require("harpoon"):list():next() end,
      desc = "Harpoon Next"
    },
  },
}
