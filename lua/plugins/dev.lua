-- Stores all neovim plugins that I am currently working on my local machine
-- Checks if a path is valid
local valid_projects = {}

---@private
local function validate_plugin_dir(plugin_spec)
  if vim.fn.isdirectory(plugin_spec.dir) == 1 then
    table.insert(valid_projects, plugin_spec)
  end
end

local nvim_dir = "/home/doozku/Projects/neovim"
validate_plugin_dir({
  dir = nvim_dir .. "/llm_chat",
  name = "llm_chat",
  config = function()
    require("llm_chat").setup()
  end,
  keys = {
    {
      "<leader>ln",
      function()
        require('llm_chat').new_chat()
      end
    },

    { "<leader>ls",
      function()
        require('llm_chat').send_message()
      end
    },
  }
})

-- validate_plugin_dir({
--   dir = nvim_dir .. "/quick-spell.nvim/",
--   name = "quick-spell",
--   keys = { {
--     '<C-;>',
--     function() require("quick-spell").correct_word() end,
--     mode = { 'n', 'i' },
--   } }
-- })
--
-- validate_plugin_dir({
--   dir = nvim_dir .. "/present.nvim",
--   config = function()
--     require('present')
--   end
-- })

validate_plugin_dir({
  dir = nvim_dir .. "/gptua/",
  name = "gptua",
  lazy = false
})

return valid_projects
