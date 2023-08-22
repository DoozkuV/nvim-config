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
vim.keymap.set('i', '<C-H>', "<C-W>")
-- Instantly go to the beginning and end of lines in insert mode (Emacs style)
vim.keymap.set('i', '<C-e>', '<C-o>$')
vim.keymap.set('i', '<C-a>', '<C-o>0')

-- Open Oil file manager
vim.keymap.set("n", "<leader>.", require("oil").open, { desc = "Open parent directory" })
