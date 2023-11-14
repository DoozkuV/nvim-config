-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for centering cursor upon hitting Ctrl-U and D
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', '<C-d>', "<C-d>zz")

-- Binding in insert mode for deleting the last block of text
-- Apparently <C-BS> auto binds to <C-H> in st...
-- vim.keymap.set('i', '<C-H>', "<C-W>")
-- Instantly go to the beginning and end of lines in insert mode (Emacs style)
-- vim.keymap.set('i', '<C-e>', '<C-o>$')
-- vim.keymap.set('i', '<C-a>', '<C-o>_')

-- Better keybind for switching to last buffer
vim.keymap.set('n', '<leader>`', '<C-^>', { desc = "Open Previous Buffer" })

-- [[ Oil ]]
-- Open Oil file manager
vim.keymap.set("n", "<leader>.", require("oil").open, { desc = "Open parent directory" })

-- [[ Neo-tree ]]
-- Neo-tree file list
vim.keymap.set("n", "<leader>op", ':Neotree toggle<cr>', { desc = "Open File Tree" })
-- Open Neo-tree buffer list
vim.keymap.set("n", "<leader>ob", ':Neotree toggle show buffers right<cr>', { desc = "[O]pen [B]uffer list" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- Open Functions
vim.keymap.set("n", "<leader>ol", ':Lazy<cr>', { desc = "[O]pen [L]azy" })
vim.keymap.set("n", "<leader>om", ':Mason<cr>', { desc = "[O]pen [M]ason" })
-- The following runs a command that opens a new terminal window
vim.keymap.set("n", "<leader>ot", ':!setsid -f $TERMINAL >/dev/null 2>&1<cr><cr>', { desc = "[O]pen [T]erminal" })

-- [[ Toggles ]]
vim.keymap.set("n", "<leader>tp", ":TogglePencil<cr>", { desc = "[T]oggle [P]encil" })
vim.keymap.set("n", "<leader>tz", ":ZenMode<cr>", { desc = "[T]oggle [Z]en Mode" })
vim.keymap.set("n", "<leader>ts", ":set spell!<cr>", { desc = "[T]oggle [S]pellcheck" })
-- '<leader>tm' toggles markdown-preview... see markdown.lua
