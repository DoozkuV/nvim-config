return {
  'jmbuhr/otter.nvim',
  enabled = false,
  ft = otter_ft,
  config = function()
    local otter_languages = { 'python', 'lua', 'bash', 'sh', 'javascript', 'css' }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = otter_ft,
      callback = function()
        require("otter").activate(otter_languages, true, true)
      end,
    })
  end
}
