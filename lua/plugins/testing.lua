-- Checks if a path is valid
local valid_projects = {}
local function validate_plugin_dir(plugin_spec)
  if vim.fn.isdirectory(plugin_spec.dir) == 1 then
    table.insert(valid_projects, plugin_spec)
  end
end

validate_plugin_dir({
  dir = "/home/doozku/Projects/Neovim/scratch-buffer",
  name = "scratch-buffer",
  config = function()
    require("scratch-buffer").setup()
  end,
  enabled = false
})

-- validate_plugin_dir({
--   dir = "/home/doozku/Projects/spell-check.nvim/",
--   name = "spell-check",
--   keys = { {
--     '<C-;>',
--     function() require("spell-check").correct_word() end,
--     mode = { 'n', 'i' },
--   } }
-- })
-- Stores all neovim plugins that I am currently working on my local machine
return valid_projects
