-- Set space to a No-Op
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for centering cursor upon hitting Ctrl-U and D
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', "<C-d>", "<C-d>zz")

-- Binding in insert mode for deleting the last block of text
-- Backspace tends to be binded to ctrl-h keymap in many terminals
-- So we just bind it to both of these keymaps.
vim.keymap.set('i', '<C-BS>', "<C-W>")
vim.keymap.set('i', '<C-H>', "<C-W>")

-- Better keybind for switching to last buffer
vim.keymap.set('n', '<leader>`', '<C-^>', { desc = "Open Previous Buffer" })

-- Bindings for quickly evaluating lua code and files
vim.keymap.set('n', "<leader>x", "<cmd>.lua<CR>", { desc = "Exec current line" })
vim.keymap.set('n', "<leader>X", "<cmd>source %<CR>", { desc = "Exec current file" })

-- [[ Quickfix List ]]
-- Navigation
vim.keymap.set('n', "<C-M-j>", '<cmd>cnext<CR>')
vim.keymap.set('n', "<C-M-k>", '<cmd>cprev<CR>')

-- Opening and Closing
vim.keymap.set('n', "<leader>cc", '<cmd>cclose<CR>')
vim.keymap.set('n', "<leader>co", '<cmd>copen<CR>')

-- [[ Oil ]]
-- Open Oil file manager
vim.keymap.set("n", "<leader>.", require("oil").open, { desc = "Open parent directory" })

-- [[ Diagnostics ]]
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Open ]]
vim.keymap.set("n", "<leader>ol", ':Lazy<cr>', { desc = "Open Lazy", silent = true })
vim.keymap.set("n", "<leader>om", ':Mason<cr>', { desc = "Open Mason", silent = true })
-- Opens the "Inspect" Treesitter view
vim.keymap.set("n", "<leader>oi", ':InspectTree<cr>', { desc = "Open Inspect Tree", silent = true })
-- Opens the lspinfo view
vim.keymap.set("n", "<leader>os", ':LspInfo<cr>', { desc = "Open Server Info", silent = true })


-- [[ Toggles ]]
vim.keymap.set("n", "<leader>tp", ":TogglePencil<cr>", { desc = "Toggle Pencil", silent = true })
-- set("n", "<leader>tz", ":ZenMode<cr>", { desc = "Toggle Zen Mode", silent = true })
-- set("n", "<leader>ts", ":setlocal spell!<cr>", { desc = "Toggle Spellcheck", silent = true })
vim.keymap.set("n", "<leader>ts", function()
  local new = not vim.opt_local.spell:get()
  vim.opt_local.spell = new
  print("Spelling " .. (new and "enabled" or "disabled"))
end, { desc = "Toggle Spellcheck", silent = true })

vim.keymap.set("n", "<leader>br", ":e<cr>", { desc = "Buffer Revert", silent = true })
-- '<leader>tm' toggles markdown-preview... see markdown.lua
