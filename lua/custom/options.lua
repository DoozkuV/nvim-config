-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Tab Configuration
vim.o.tabstop = 4       -- Num of spaces normal tabs are rendered as
vim.o.shiftwidth = 4    -- Num spaces inserted when using spaces instead of tabs
vim.o.softtabstop = -1  -- Num spaces inserted when hitting <Tab> in insert mode
vim.o.expandtab = false -- Make tabs into spaces


-- Make long lines wrap at word endings
vim.o.linebreak = true

-- Keep 'x' amount of lines on screen at all times
vim.wo.scrolloff = 10

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- For the obsidian plugin
vim.opt.conceallevel = 2

-- Set background to be transparent
vim.cmd [[ highlight Normal guibg=NONE ctermbg=NONE ]]

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})
