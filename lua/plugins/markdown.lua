local function toggle()
  local peek = require("peek")
  if peek.is_open() then
    print("Closing Peek")
    peek.close()
  else
    print("Opening Peek")
    peek.open()
  end
end

return {
  'toppair/peek.nvim',
  event = { "VeryLazy" },
  build = 'deno task --quiet build:fast',
  keys = {
    {
      "<leader>oP",
      toggle,
      desc = "Markdown Preview Toggle"
    }
  },
  opts = {
    auto_load = false,
    close_on_bdelete = true,
    syntax = true,
    theme = "dark",
    update_on_change = true,
    app = "webview",
    filetype = { "markdown" },
  }
}
