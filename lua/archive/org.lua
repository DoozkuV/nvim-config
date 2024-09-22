local default_org_dir = "~/Documents/org"
-- This package
return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = default_org_dir .. '/**/*',
        org_default_notes_file = default_org_dir .. '/in.org',
        org_todo_keywords = {
          'TODO(t)', 'NEXT(n)', 'HOLD(h!)',
          'WAIT(w@)', 'IN(i)', 'MAYBE(m)',
          '|', 'DONE(d!)', 'CANCELLED(c!)'
        },
        org_capture_tempaltes = {
          i = {
            description = "in",
            template = "* IN %?\n %U\n"
          }
        },
        org_archive_location = default_org_dir .. '/archive.org::* %s',
      })
    end,
    enabled = false,
  },

  -- Org Roam functionality
  {
    "chipsenkbeil/org-roam.nvim",
    event = 'VeryLazy',
    dependencies = { "nvim-orgmode/orgmode" },
    config = function()
      require("org-roam").setup({
        directory = default_org_dir .. "/roam",
      })
    end,
    enabled = false,
  },
  -- Org Table Feature - Might move this somewhere else in the future
  -- Default binding is <Leader>tm
  {
    'dhruvasagar/vim-table-mode',
    -- keys = {
    --   {
    --     '<leader>tm',
    --
    --
    --   }
    -- }
    enabled = false
  },
}
