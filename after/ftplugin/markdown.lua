-- Enable spellchecking automatically in markdown buffers
vim.opt_local.spell = true

-- Create keybinds for italicizing and bolding text
vim.api.nvim_buf_set_keymap(0, 'i', '<C-i>', '**<ESC>i', { silent = true, noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', '<C-b>', '****<ESC>hi', { silent = true, noremap = true })
