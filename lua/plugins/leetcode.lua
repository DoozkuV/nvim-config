-- Args to open leetcode.nvim
local leet_arg = "leetcode.nvim"

-- Keybinds to be set on opening a leetcode question buffer
---@private
local set_binds = function(question)
  local buf = question.bufnr

  local function leetmap(lhs, rhs, desc)
    vim.keymap.set("n", '<LocalLeader>' .. lhs,
      ':Leet ' .. rhs .. '<CR>',
      { silent = true, buffer = buf, desc = desc })
  end

  leetmap('t', 'run', 'Run Tests')
  leetmap('s', 'submit', 'Submit')
  leetmap('l', 'lang', 'Set Language')
  leetmap('d', 'desc', 'Toggle Description')
end

return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  lazy = leet_arg ~= vim.fn.argv()[1],
  opts = {
    arg = leet_arg,
    lang = "python3",
    hooks = {
      ["question_enter"] = { set_binds },
    },

    injector = {
      ["cpp"] = {
        before = { "#include <bits/stdc++.h>", "using namespace std;" },
        after = "int main() {}",
      }
    }
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    -- "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
}
