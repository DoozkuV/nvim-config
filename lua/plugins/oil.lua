-- Oil file manager
-- Keybind to open set in the main init.lua file
return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    restore_win_options = true,
    keymaps = {
      ["q"] = "actions.close",
      ["h"] = "actions.parent",
      ["l"] = "actions.select",
    }
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
