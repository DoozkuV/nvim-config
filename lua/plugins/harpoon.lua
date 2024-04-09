-- Hook onto files for fast access
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",                        -- use the modern version
  dependencies = { "nvim-lua/plenary.nvim" }, -- "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    -- harpoon:setup({}) -- Mandatory for harpoon to function

    -- basic telescope config
    -- local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require("telescope.pickers").new({}, {
    --     prompt_title = "Harpoon",
    --     finder = require("telescope.finders").new_table({
    --       results = file_paths,
    --     }),
    --     previewer = conf.file_previewer({}),
    --     sorter = conf.generic_sorter({}),
    --   }):find()
    -- end
  end,

  keys = {
    {
      '<leader>a',
      function() require("harpoon"):list():add() end,
      desc = '[A]dd Mark'
    },
    {
      '<leader>q',
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = '[Q]uick Menu'
    },
    {
      '<leader>h',
      function() require("harpoon"):list():select(1) end,
      desc = 'Harpoon [1]'
    },
    {
      '<leader>j',
      function() require("harpoon"):list():select(2) end,
      desc = 'Harpoon [2]'
    },
    {
      '<leader>k',
      function() require("harpoon"):list():select(3) end,
      desc = 'Harpoon [3]'
    },
    {
      '<leader>l',
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
