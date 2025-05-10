-- Utility function for returning pairs for the surroundings
local function surround_pair(lhs, rhs)
  return {
    [lhs] = { add = { lhs, rhs } },
    [rhs] = { add = { lhs .. " ", " " .. rhs } },
  }
end

-- Plugins dedicated to adding new motions to nvim
return {
  {
    -- Nvim-surround - Simple surround motions
    "kylechui/nvim-surround",
    --[[
    This plugin lets one use a single motion in order to 'surround' a token with a
    wanted symbol. The three "core" operations of 'add', 'delete', and 'change' can
    be done with the keymaps 'ys{motion}{char}', ds{char}, and cs{target}{replacement},
    respectively. For the following examples, '*' will denote the cursor position:
      Old text                    Command         New text
  -------------------------------------------------------------------------------
      surr*ound_words             ysiw)           (surround_words)
      *make strings               ys$"            "make strings"
      [delete ar*ound me!]        ds]             delete around me!
      remove <b>HTML t*ags</b>    dst             remove HTML tags
      'change quot*es'            cs'"            "change quotes"
      <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
      delete(functi*on calls)     dsf             function calls
  ]]
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    keys = {
      "ys", "ds", "cs", 'S'
    },
    opts = {
      surrounds = vim.tbl_deep_extend("force",
        surround_pair("(", ")"),
        surround_pair("[", "]"),
        surround_pair("{", "}"),
        surround_pair("<", ">")
      ),
    },
  },

  -- NOTE: As of Neovim v10, this feature is now native in Neovim
  -- Nevertheless, this plugin seems to provide more intelligent features
  -- so it will stick around in this configuration.
  -- See https://github.com/numToStr/Comment.nvim/issues/453 for more info
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {}, keys = { "gc", "gb" } },
  -- Add emacs-like bindings to vim in insert/commandline mode
  -- "tpope/vim-rsi",
}
