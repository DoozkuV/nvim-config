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
        desc = 'Git Open',
      },
      {
        "<leader>go",
        function()
          require('neogit').open({ kind = "split" })
        end,
        desc = 'Git Open Split',
      },
      {
        "<leader>gc",
        ":Neogit commit<cr>",
        desc = 'Git Commit Open',
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
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
        local gitsigns = require('gitsigns')

        vim.keymap.set('n', '<leader>gh', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' })
        vim.keymap.set('n', 'ghn', function()
          gitsigns.nav_hunk('prev')
        end, { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', 'ghp', function()
          gitsigns.nav_hunk('next')
        end, { buffer = bufnr, desc = 'Go to Next Hunk' })
      end,
    },
  },
}
