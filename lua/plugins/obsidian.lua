-- TODO: Implement a better templating setup for this config.
-- See this issue: https://github.com/epwalsh/obsidian.nvim/issues/456
-- Define variables for the workspaces here
local function validate_workspaces(workspaces)
  local valid_workspaces = {}
  for _, workspace in ipairs(workspaces) do
    if vim.fn.isdirectory(vim.fn.expand(workspace.path)) == 1 then
      table.insert(valid_workspaces, workspace)
    end
  end
  return valid_workspaces
end

local workspaces = validate_workspaces({
  {
    name = "main",
    path = "~/Dropbox/obsidian",
    overrides = {
      notes_subdir = "in",
      new_notes_location = "notes_subdir",
      daily_notes = {
        folder = "dailies",
        template = "templates/daily.md"
      },
      templates = {
        folder = "templates",
      }
    },
  },
  -- {
  --   name = "arden",
  --   path = "~/Documents/DND/arden-campaign",
  --   overrides = {
  --     daily_notes = {
  --       folder = "sessions",
  --     }
  --   }
  -- },
  {
    name = "start-up",
    path = "~/Documents/start-up",
    overrides = {
      daily_notes = {
        folder = "agile-scrum"
      }
    }
  }
})

-- Lazy loading setup - see :h obsidian.txt for more
-- This code auto-generates the code needed for any number of workspaces
local workspace_event_strings = {}
for _, workspace in ipairs(workspaces) do
  local path = vim.fn.expand(workspace.path .. "/**.md")
  table.insert(workspace_event_strings, "BufReadPre " .. path)
  table.insert(workspace_event_strings, "BufNewFile " .. path)
end

return {
  'epwalsh/obsidian.nvim',
  version = "*",
  lazy = true,
  event = workspace_event_strings,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = workspaces,

    -- Where to put new notes created from completion. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "notes_subdir",

    -- Code for naming new notes
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
        opts = { buffer = true, desc = "Toggle Checkbox" },
      },
      ["<LocalLeader>o"] = {
        action = ":ObsidianOpen<cr>",
        opts = { buffer = true, desc = "Open Obsidian" },
      },
      ["<LocalLeader>V"] = {
        action = ":ObsidianPasteImg<cr>",
        opts = { buffer = true, desc = "V Paste Image" },
      },
      ["<LocalLeader>r"] = {
        action = ":ObsidianRename ",
        opts = { buffer = true, desc = "Rename Note" },
      },
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },

    note_frontmatter_func = function(note)
      -- Automatically create ID and tags
      local out = { id = note.id, tags = note.tags }

      if note.aliases ~= nil then out.aliases = note.aliases end

      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end
  },
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
      desc = 'Obsidian: R New Create',
    },
    {
      '<leader>rf',
      ":ObsidianQuickSwitch<cr>",
      desc = 'Obsidian: R Note Find'
    },
    {
      '<leader>rs',
      ":ObsidianSearch<cr>",
      desc = 'Obsidian: R Note Search'
    },
    {
      '<leader>rw',
      ":ObsidianWorkspace ",
      desc = 'Obsidian: R Select Workspace'
    },
    {
      '<leader>rd',
      ":ObsidianToday<cr>",
      desc = 'Obsidian: R Open Daily Note',
    },
    {
      '<leader>rt',
      ":ObsidianTemplate<cr>",
      desc = 'Obsidian: R Create From Template',
    },
    { -- Function to delete all open Obsidian Buffers
      '<leader>rr',
      function()
        -- Get all listed buffers
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
        for _, buffer in ipairs(buffers) do
          for _, workspace in ipairs(workspaces) do
            -- If the listed buffer's directory is the directory
            -- delete the buffer (not forcibly)
            if vim.startswith(vim.fn.fnamemodify(buffer.name, ":~:h"), workspace.path) then
              vim.api.nvim_buf_delete(buffer.bufnr, {})
              break
            end
          end
        end
      end,
      desc = "Obsidian: R Return"
    }
  },
}
