-- A list of plugins for use while writing
return {
  -- {
  --   -- A plugin to add a sort of "zen mode" to vim.
  --
  --   'junegunn/goyo.vim',
  --   cmd = "Goyo"
  -- },
  {
    -- A plugin to add a sort of "zen mode" to vim.
    "folke/zen-mode.nvim",
    cmd = "ZenMode"
  },
  {
    -- Plugin designed to manage line wrapping
    'preservim/vim-pencil',
    cmd = {
      "Pencil", "TogglePencil", "SoftPencil", "HardPencil"
    },
  }
}
