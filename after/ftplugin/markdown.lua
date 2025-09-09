--- Inserts the delimiter and places the cursor in the middle. If already inside the delimiter, pushes the cursor out
---@param del string
local function insert_delimiters(del)
    local line = vim.api.nvim_get_current_line()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor_pos[1], cursor_pos[2]

    -- Check if the character after cursor is an asterisk
    if col < #line - #del + 1 and string.sub(line, col + 1, col + #del) == del then
        -- Move cursor after asterisk
        vim.api.nvim_win_set_cursor(0, { row, col + #del })
    else
        -- Insert asterisk and place cursor between them
        local new_line = string.sub(line, 1, col) .. del .. del .. string.sub(line, col + 1)
        vim.api.nvim_set_current_line(new_line)
        vim.api.nvim_win_set_cursor(0, { row, col + #del })
    end
end


-- Set them keybinds
local keymap_opts = { noremap = true, buffer = true }
vim.keymap.set('i', '<C-S-i>', function() insert_delimiters('*') end, keymap_opts)
vim.keymap.set('i', '<C-b>', function() insert_delimiters('**') end, keymap_opts)

-- Enable spellchecking automatically in editable markdown buffers
if vim.bo.modifiable then
    vim.opt_local.spell = true
end
