-- Plugins related to git go here
return {
  -- Git commands
  -- This automatically loads only when in a Git Repo
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',
  {
    "NeogitOrg/neogit",
    config = true,
    cmd = "Neogit",
    keys = {
      {
        "<leader>gg",
        ":Neogit<cr>",
        desc = '[G]it Open',
      },
      {
        "<leader>gc",
        ":Neogit commit<cr>",
        desc = '[G]it [C]ommit Open',
      }
    },
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview [H]unk' })
      end,
    },
  },
}
