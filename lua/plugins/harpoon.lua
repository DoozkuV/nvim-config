-- Hook onto files for fast access
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",                        -- use the modern version
  dependencies = { "nvim-lua/plenary.nvim" }, -- "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      -- Set up running shell commands in another buffer
      popup = {
        create_list_item = function(possible_value)
          return {
            value = vim.fn.input({ prompt = "Enter cmd: ", completion = 'shellcmd' }),
          }
        end,
        select = function(list_item, list, option)
          if vim.fn.getenv('TMUX') then
            vim.fn.system("tmux popup -d '#{pane_current_path}' "
              .. "-w 75% -h 80% "
              .. list_item.value)
          end
        end
      }
    })
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
      '<C-r>',
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
      '<leader>cm',
      function() require("harpoon"):list('popup'):add() end,
      desc = 'Command Mark'
    },
    {
      '<leader>cq',
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list('popup'))
      end,
      desc = 'Command Quick Menu'
    },
    {
      '<leader>ch',
      function() require("harpoon"):list('popup'):select(1) end,
      desc = 'Harpoon Command [1]'
    },
    {
      '<leader>cj',
      function() require("harpoon"):list('popup'):select(2) end,
      desc = 'Harpoon Command [2]'
    },
    {
      '<leader>ck',
      function() require("harpoon"):list('popup'):select(3) end,
      desc = 'Harpoon Command [3]'
    },
    {
      '<leader>cl',
      function() require("harpoon"):list('popup'):select(4) end,
      desc = 'Harpoon Command [4]'
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
