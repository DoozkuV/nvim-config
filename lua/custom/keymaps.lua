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
-- Backspace tends to be binded to ctrl-h keymap in many terminals
-- So we just bind it to both of these keymaps.
vim.keymap.set('i', '<C-BS>', "<C-W>")
vim.keymap.set('i', '<C-H>', "<C-W>")

-- Enter key remapping to make a new line
vim.keymap.set('n', '<CR>', 'O<Esc>')

-- Better keybind for switching to last buffer
vim.keymap.set('n', '<leader>`', '<C-^>', { desc = "Open Previous Buffer" })

-- [[ Oil ]]
-- Open Oil file manager
vim.keymap.set("n", "<leader>.", require("oil").open, { desc = "Open parent directory" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- Open Functions
vim.keymap.set("n", "<leader>ol", ':Lazy<cr>', { desc = "[O]pen [L]azy", silent = true })
vim.keymap.set("n", "<leader>om", ':Mason<cr>', { desc = "[O]pen [M]ason", silent = true })
-- The following runs a command that opens a new terminal window
vim.keymap.set("n", "<leader>ot", ':!setsid -f $TERMINAL >/dev/null 2>&1<cr><cr>',
  { desc = "[O]pen [T]erminal", silent = true })
-- Opens the "Inspect" Treesitter view
vim.keymap.set("n", "<leader>oi", ':InspectTree<cr>', { desc = "[O]pen [I]nspect Tree", silent = true })
-- Opens the lspinfo view
vim.keymap.set("n", "<leader>os", ':LspInfo<cr>', { desc = "[O]pen [S]erver Info", silent = true })

-- [[ Toggles ]]
vim.keymap.set("n", "<leader>tp", ":TogglePencil<cr>", { desc = "[T]oggle [P]encil", silent = true })
-- vim.keymap.set("n", "<leader>tz", ":ZenMode<cr>", { desc = "[T]oggle [Z]en Mode", silent = true })
vim.keymap.set("n", "<leader>ts", ":setlocal spell!<cr>", { desc = "[T]oggle [S]pellcheck", silent = true })

vim.keymap.set("n", "<leader>br", ":e<cr>", { desc = "[B]uffer [R]evert", silent = true })
-- '<leader>tm' toggles markdown-preview... see markdown.lua
