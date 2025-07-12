-- My personal spell-check plugin
return {
  "DoozkuV/quick-spell.nvim",
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = { {
    '<C-;>',
    function() require("quick-spell").correct_word() end,
    mode = { 'n', 'i' },
  } },
}
