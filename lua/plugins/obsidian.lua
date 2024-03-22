-- Define variables for the workspaces here
-- These are considered to be relative to the home dir
local second_brain_dir = "/Documents/Obsidian/second-brain"
local arden_campaign_dir = "/Documents/DND/arden-campaign"
local obsidian_directories = { second_brain_dir, arden_campaign_dir }


-- Lazy loading setup - see :h obsidian.txt for more
-- This code auto-generates the code needed for any number of workspaces
local workspace_event_strings = {}
for _, dir in ipairs(obsidian_directories) do
  local path = vim.fn.expand "~" .. dir .. "/**.md"
  table.insert(workspace_event_strings, "BufReadPre " .. path)
  table.insert(workspace_event_strings, "BufNewFile " .. path)
end
-- Plugin for managing obsidian notes
return {
  'epwalsh/obsidian.nvim',
  version = "*",
  lazy = true,
  event = workspace_event_strings,
  cmd = {
    "ObsidianQuickSwitch",
    "ObsidianNew",
    "ObsidianToday",
    "ObsidianSearch",
    "ObsidianWorkspace"
  },
  keys = {
    {
      '<leader>rc',
      ":ObsidianNew ",
      desc = 'Obsidian: [R] New [C]reate',
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
    {
      '<leader>rr',
      function()
        -- Get all listed buffers
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
        for _, buffer in ipairs(buffers) do
          for _, directory in ipairs(obsidian_directories) do
            -- If the listed buffer's directory is the directory
            -- delete the buffer (not forcibly)
            if vim.startswith(vim.fn.fnamemodify(buffer.name, ":~:h"), "~" .. directory) then
              vim.api.nvim_buf_delete(buffer.bufnr, {})
              break
            end
          end
        end
      end,
      desc = "Obsidian: [R] [R]eturn"
    }
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
            template = "templates/daily.md"
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
    note_id_func = function(title)
      return title
    end,
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
        -- action = ":ObsidianOpen<cr>",
        action = function()
          vim.fn.system([[
            notify-send -u low -t 1500 \
            -i /usr/share/pixmaps/obsidian.png \
            'Obsidian is Opening!'
            ]])
          vim.cmd('ObsidianOpen')
        end,
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
