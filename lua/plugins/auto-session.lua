return {
  'rmagatti/auto-session',
  opts = {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  }
  -- config = function()
  --   require("auto-session").setup {
  --     log_level = "error",
  --     auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
  --   }
  -- end
}
