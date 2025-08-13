-- Convenience alias
local set = vim.keymap.set

set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for centering cursor upon hitting Ctrl-U and D
set('n', '<C-u>', "<C-u>zz")
set('n', "<C-d>", "<C-d>zz")

-- Binding in insert mode for deleting the last block of text
-- Backspace tends to be binded to ctrl-h keymap in many terminals
-- So we just bind it to both of these keymaps.
vim.keymap.set('i', '<C-BS>', "<C-W>")
vim.keymap.set('i', '<C-H>', "<C-W>")

-- Better keybind for switching to last buffer
set('n', '<leader>`', '<C-^>', { desc = "Open Previous Buffer" })


-- Binding for quickly evaluating a line
set('n', "<leader>x", "<cmd>.lua<CR>", { desc = "Exec current line" })
set('n', "<leader>X", "<cmd>source %<CR>", { desc = "Exec current file" })

-- [[ Quickfix List ]]
-- Quick navigation
set('n', "<C-S-j>", '<cmd>cnext<CR>')
set('n', "<C-S-k>", '<cmd>cprev<CR>')
-- Opening and Closing
set('n', "<leader>cc", '<cmd>cclose<CR>')
set('n', "<leader>co", '<cmd>copen<CR>')

-- [[ Oil ]]
-- Open Oil file manager
set("n", "<leader>.", require("oil").open, { desc = "Open parent directory" })

set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
set('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- Open Functions
set("n", "<leader>ol", ':Lazy<cr>', { desc = "Open Lazy", silent = true })
set("n", "<leader>om", ':Mason<cr>', { desc = "Open Mason", silent = true })
-- Opens the "Inspect" Treesitter view
set("n", "<leader>oi", ':InspectTree<cr>', { desc = "Open Inspect Tree", silent = true })
-- Opens the lspinfo view
set("n", "<leader>os", ':LspInfo<cr>', { desc = "Open Server Info", silent = true })


-- [[ Toggles ]]
set("n", "<leader>tp", ":TogglePencil<cr>", { desc = "Toggle Pencil", silent = true })
-- set("n", "<leader>tz", ":ZenMode<cr>", { desc = "Toggle Zen Mode", silent = true })
-- set("n", "<leader>ts", ":setlocal spell!<cr>", { desc = "Toggle Spellcheck", silent = true })
set("n", "<leader>ts", function()
  local new = not vim.opt_local.spell:get();
  vim.opt_local.spell = new
  print("Spelling " .. (new and "enabled" or "disabled"))
end, { desc = "Toggle Spellcheck", silent = true })

set("n", "<leader>br", ":e<cr>", { desc = "Buffer Revert", silent = true })
-- '<leader>tm' toggles markdown-preview... see markdown.lua
