-- Define variables for the workspaces here
-- These are considered to be relative to the home dir
local second_brain_dir = "/Documents/Obsidian/second-brain"
local arden_campaign_dir = "/Documents/DND/arden_campaign"
-- Plugin for managing obsidian notes
return {
  'epwalsh/obsidian.nvim',
  version = "*",
  lazy = true,
  -- Lazy loading setup - see :h obsidian.txt for more
  event = {
    -- This syntax is required for the file path expansion
    -- School notes
    "BufReadPre " .. vim.fn.expand "~" .. second_brain_dir .. "/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. second_brain_dir .. "/**.md",
    -- Dungeons and Dragons Notes
    "BufReadPre " .. vim.fn.expand "~" .. arden_campaign_dir .. "/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. arden_campaign_dir .. "/**.md",
  },
  keys = {
    -- {
    --   '<leader>rn',
    --   ":ObsidianNew ",
    --   desc = 'Obsidian: [R] New [N]ote',
    -- },
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
    {
      '<leader>rd',
      ":ObsidianToday<cr>",
      desc = 'Obsidian: [R] Open [D]aily Note',
    },
    {
      '<leader>rt',
      ":ObsidianTemplate<cr>",
      desc = 'Obsidian: [R] Create From [T]emplate',
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "second-brain",
        path = "~" .. second_brain_dir,
        overrides = {
          daily_notes = {
            folder = "dailies",
          },
          -- Return the title with no names or other modifications
          -- note_id_func = function(title)
          --   return title
          -- end,
        }
      },
      {
        name = "arden",
        path = "~" .. arden_campaign_dir,
        overrides = {
          daily_notes = {
            folder = "sessions",
          }
        }
      },
    },

    -- Where to put new notes created from completion. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "notes_subdir",

    -- Code for naming new notes
    -- note_id_func = function(title)
    --   return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower() -- Lowercase version of title
    -- end,
    -- New function for returning notes - we just want the title.
    -- note_id_func = function(title)
    --   return title
    -- end,
    -- Code for opening urls
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({ "xdg-open", url }) -- linux
    end,

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within vault
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
