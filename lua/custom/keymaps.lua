-- Convenience alias
local set = vim.keymap.set

set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for centering cursor upon hitting Ctrl-U and D
set('n', '<C-u>', "<C-u>zz")
set('n', '<C-d>', "<C-d>zz")

-- Binding in insert mode for deleting the last block of text
-- Backspace tends to be binded to ctrl-h keymap in many terminals
-- So we just bind it to both of these keymaps.
set('i', '<C-BS>', "<C-W>")
set('i', '<C-H>', "<C-W>")

-- Better keybind for switching to last buffer
set('n', '<leader>`', '<C-^>', { desc = "Open Previous Buffer" })


-- Binding for quickly evaluating a line
set('n', "<leader>x", "<cmd>.lua<CR>", { desc = "Exec current line" })
set('n', "<leader>X", "<cmd>source %<CR>", { desc = "Exec current file" })

-- [[ Oil ]]
-- Open Oil file manager
set("n", "<leader>.", require("oil").open, { desc = "Open parent directory" })

-- Diagnostic keymaps
set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- Open Functions
set("n", "<leader>ol", ':Lazy<cr>', { desc = "Open Lazy", silent = true })
set("n", "<leader>om", ':Mason<cr>', { desc = "Open Mason", silent = true })
-- The following runs a command that opens a new terminal window
set("n", "<leader>ot", ':!setsid -f $TERMINAL >/dev/null 2>&1<cr><cr>',
  { desc = "Open Terminal", silent = true })
-- Opens the "Inspect" Treesitter view
set("n", "<leader>oi", ':InspectTree<cr>', { desc = "Open Inspect Tree", silent = true })
-- Opens the lspinfo view
set("n", "<leader>os", ':LspInfo<cr>', { desc = "Open Server Info", silent = true })

-- [[ Toggles ]]
set("n", "<leader>tp", ":TogglePencil<cr>", { desc = "Toggle Pencil", silent = true })
-- set("n", "<leader>tz", ":ZenMode<cr>", { desc = "Toggle Zen Mode", silent = true })
-- set("n", "<leader>ts", ":setlocal spell!<cr>", { desc = "Toggle Spellcheck", silent = true })
set("n", "<leader>ts", function()
  vim.opt_local.spell = not vim.opt_local.spell;
  print("Spelling " .. (vim.opt_local.spell == true and "enabled" or "disabled"))
end, { desc = "Toggle Spellcheck", silent = true })

set("n", "<leader>br", ":e<cr>", { desc = "Buffer Revert", silent = true })
-- '<leader>tm' toggles markdown-preview... see markdown.lua
