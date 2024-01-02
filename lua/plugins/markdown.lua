-- A series of plugins designed to assist while editing markdown files

return {
  -- { -- A plugin that provides a nice live preview while editing markdown text
  --   'iamcco/markdown-preview.nvim',
  --   ft = 'markdown',
  --   config = function()
  --     -- Can only call functions on the proper filetype
  --     vim.g.mkdp_filetypes = { 'markdown' }
  --     -- Set the markdown command
  --     vim.keymap.set("n", "<leader>tm", ":MarkdownPreviewToggle<cr>", { desc = "[T]oggle [M]arkdown Preview" })
  --   end,
  --   -- Plugin doesn't work without this line
  --   build = "cd app && npm install",
  -- },
  -- -- A plugin that adds several different utilities for editing md files
  -- { 'ixru/nvim-markdown', ft = 'markdown' }
  --
  'epwalsh/obsidian.nvim',
  version = "*",
  lazy = true,
  -- Lazy loading setup - see :h obsidian.txt for more
  event = {
    -- This syntax is required for the file path expansion
    -- School notes
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/spring2024/school-notes/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/spring2024/school-notes/**.md",
    -- Dungeons and Dragons Notes
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/DND/arden-campaign/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/DND/arden-campaign/**.md",
  },
  keys = {
    {
      '<leader>rn',
      ":ObsidianNew ",
      desc = 'Obsidian: [R] New [N]ote',
    },
    {
      '<leader>rf',
      ":ObsidianQuickSwitch<cr>",
      desc = 'Obsidian: [R] Note [F]ind'
    },
    {
      '<leader>rs',
      ":ObsidianSearch<cr>",
      desc = 'Obsidian: [R] Note [S]earch'
    },
    {
      '<leader>rw',
      ":ObsidianWorkspace ",
      desc = 'Obsidian: [R] Select [W]orkspace'
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "School",
        path = "~/Documents/spring2024/school-notes",
      },
      {
        name = "Arden",
        path = "~/Documents/DND/arden-campaign",
      },
    },
    -- Code for naming new notes
    note_id_func = function(title)
      return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower() -- Lowercase version of title
    end,
    -- Code for opening urls
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({ "xdg-open", url }) -- linux
    end,

    mappings = {
      -- Overrides the 'gf' mapping to work kon markdown/wiki links within vault
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = {
          noremap = false,
          expr = true,
          buffer = true,
          desc = "Go to Obsidian Link"
        }
      },
      ["<LocalLeader>c"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true, desc = "Toggle [C]heckbox" },
      },
      ["<LocalLeader>o"] = {
        action = ":ObsidianOpen<cr>",
        opts = { buffer = true, desc = "[O]pen Obsidian" },
      },
      ["<LocalLeader>V"] = {
        action = ":ObsidianPasteImg<cr>",
        opts = { buffer = true, desc = "[V] Paste Image" },
      },
      ["<LocalLeader>r"] = {
        action = ":ObsidianRename ",
        opts = { buffer = true, desc = "[R]ename Note" },
      },
    }
  },
}
