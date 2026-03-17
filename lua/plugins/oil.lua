-- Oil file manager
-- Keybind to open set in the main init.lua file
return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    restore_win_options = true,
    cleanup_delay_ms = 2000,
    watch_for_changes = true,
    keymaps = {
      ["q"] = "actions.close",
      -- Disable these commands - they are really annoying!
      ["H"] = "actions.parent",
      ["L"] = "actions.select",
      ["T"] = "actions.toggle_hidden",
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
