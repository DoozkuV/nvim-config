return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
      init = function()
        vim.g.no_plugin_maps = true
      end,
      config = function()
        require('nvim-treesitter-textobjects').setup {
          select = {
            lookahead = true,
          },
          move = {
            set_jumps = true,
          },
        }

        -- Textobject select keymaps
        local select = require('nvim-treesitter-textobjects.select')
        vim.keymap.set({ 'x', 'o' }, 'aa', function() select.select_textobject('@parameter.outer') end)
        vim.keymap.set({ 'x', 'o' }, 'ia', function() select.select_textobject('@parameter.inner') end)
        vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer') end)
        vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner') end)
        vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer') end)
        vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner') end)

        -- Textobject move keymaps
        local move = require('nvim-treesitter-textobjects.move')
        vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer') end)
        vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer') end)
        vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer') end)
        vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer') end)
        vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer') end)
        vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer') end)
        vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer') end)
        vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer') end)

        -- Textobject swap keymaps
        local swap = require('nvim-treesitter-textobjects.swap')
        vim.keymap.set('n', '<leader>p', function() swap.swap_next('@parameter.inner') end)
        vim.keymap.set('n', '<leader>P', function() swap.swap_previous('@parameter.inner') end)
      end,
    },
    {
      'hiphish/rainbow-delimiters.nvim',
      config = function()
        local rainbow_delimiters = require('rainbow-delimiters')
        vim.g.rainbow_delimiters = {
          strategy = {
            [''] = rainbow_delimiters.strategy['global'],
          },
          query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
          }
        }
      end
    },
  },
  main = 'nvim-treesitter',
  init = function()
    -- Enable treesitter highlighting and indentation for all filetypes
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  config = function()
    -- Ensure parsers are installed
    local ensure_installed = {
      'bash', 'c', 'cpp', 'elixir', 'fennel', 'go', 'gomod', 'gosum',
      'hyprlang', 'javascript', 'json', 'latex', 'lua',
      'markdown', 'markdown_inline', 'python', 'query', 'racket',
      'rasi', 'ruby', 'rust', 'scheme', 'sql', 'svelte', 'typescript',
      'vim', 'vimdoc', 'zig',
    }
    local installed = require('nvim-treesitter.config').get_installed()
    local to_install = vim.iter(ensure_installed)
      :filter(function(p) return not vim.tbl_contains(installed, p) end)
      :totable()
    if #to_install > 0 then
      require('nvim-treesitter').install(to_install)
    end
  end,
}
