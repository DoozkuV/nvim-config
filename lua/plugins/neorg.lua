return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = 'norg',
  cmd = "Neorg",
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {}, -- Icons
        ["core.dirman"] = {      -- Manages neorg workspaces
          config = {
            workspaces = {
              notes = "~/Documents/neorg"
            }
          }
        }
        -- ["core.keybinds"] = {
        --   config = {
        --     hook = function(keybinds)
        --       keybinds.re
        --     end,
        --   }
        -- }
      }
    }
  end,
}
