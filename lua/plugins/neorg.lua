return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
  ft = 'norg',
  cmd = "Neorg",
  keys = {
    {
      '<leader>nw',
      ':Telescope neorg switch_workspace<cr>',
      desc = '[N]eorg [W]orkspaces',
    },
    {
      '<leader>nj',
      ':Neorg journal today<cr>',
      desc = '[N]eorg [J]ournal'
    },
    {
      '<leader>ns',
      ':Telescope neorg find_norg_files<cr>',
      desc = '[N]eorg [S]earch',
    },
    {
      '<leader>ni',
      ':Neorg index<cr>',
      desc = '[N]eorg [I]ndex',
    },
    {
      '<leader>nr',
      ':Neorg return<cr>',
      desc = '[N]eorg [R]eturn',
    },
    {
      '<leader>nc',
      ':Neorg toggle-concealer<cr>',
      desc = '[N]eorg Toggle [C]oncealer',
    },
  },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {}, -- Icons
        ["core.dirman"] = {      -- Manages neorg workspaces
          config = {
            workspaces = {
              todo = "~/Documents/neorg",
              artificial_intelligence = "~/Notes/Artificial-Intelligence",
              database_systems = "~/Notes/Database-Systems",
            },
            default_workspace = "todo",
            index = "index.norg"
          }
        },
        -- Telescope integration
        ["core.integrations.telescope"] = {},
        -- Completion information
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        -- ["core.integrations.nvim-cmp"] = {},
      }

    }
    local neorg_callbacks = require("neorg.core.callbacks")

    neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
      -- Map all the below keybinds only when the "norg" mode is active
      keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
          { "<LocalLeader>sl", "core.integrations.telescope.find_linkable" },
          { "<LocalLeader>sh", "core.integrations.telescope.search_headings" },
        },

        i = { -- Bind in insert mode
          { "<C-l>", "core.integrations.telescope.insert_link" },
          { "<C-L>", "core.integrations.telescope.insert_file_link" },
        },
      }, {
        silent = true,
        noremap = true,
      })
    end)
  end,
}
