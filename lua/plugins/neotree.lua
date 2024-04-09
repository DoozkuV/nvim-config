-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  config = function()
    require('neo-tree').setup {}
  end,
  keys = {
    {
      '<leader>op',
      ':Neotree toggle<cr>',
      desc = "[O]pen File Tree [P]",
      silent = true
    },
    {
      '<leader>ob',
      ':Neotree toggle show buffers right<cr>',
      desc = "[O]pen [B]uffer list",
      silent = true
    }

  }
}
