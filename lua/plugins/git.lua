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
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
        vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' })
      end,
    },
  },
}
