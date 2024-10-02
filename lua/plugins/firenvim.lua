return {
    'glacambre/firenvim',
    enabled = true,

    lazy = not vim.g.started_by_firenvim,
    build = ":call firenvim#install(0)",
    -- Only runs when this plugin is loaded
    config = function()
        -- Disable statusline
        vim.o.laststatus = 0
    end
}
