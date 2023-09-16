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

-- [[ Oil ]]
-- Open Oil file manager
vim.keymap.set("n", "<leader>.", require("oil").open, { desc = "Open parent directory" })

-- [[ Neo-tree ]]
-- Neo-tree file list
vim.keymap.set("n", "<leader>op", ':Neotree toggle<cr>', { desc = "Open File Tree" })
-- Open Neo-tree buffer list
vim.keymap.set("n", "<leader>ob", ':Neotree toggle show buffers right<cr>', { desc = "[O]pen [B]uffer list" })

-- [[ Telescope ]]
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, { desc = '[S]earch [R]ecently opened files' })
vim.keymap.set('n', '<leader>,', require('telescope.builtin').buffers, { desc = '[,] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader> ', require('telescope.builtin').find_files, { desc = '[ ] Find Files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })


-- Open lazy
vim.keymap.set("n", "<leader>ol", ':Lazy<cr>', { desc = "Open Lazy" })
