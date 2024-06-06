-- Checks if a path is valid
local valid_projects = {}
local function validate_plugin_dir(cfg)
  if vim.fn.isdirectory(cfg.dir) == 1 then
    table.insert(valid_projects, cfg)
  end
end

-- validate_plugin_dir({
--   dir = "/home/doozku/Projects/Neovim/scratch-buffer",
--   name = "scratch-buffer",
--   config = function()
--     require("scratch-buffer").setup()
--   end
-- })

validate_plugin_dir({
  dir = "/home/doozku/Projects/Neovim/spell-check",
  name = "spell-check",
  keys = { {
    '<C-;>',
    function() require("spell-check").correct_word() end,
    mode = { 'n', 'i' },
  } }
})
-- Stores all neovim plugins that I am currently working on my local machine
return valid_projects
