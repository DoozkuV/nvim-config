--- All languages supported by treesitter
---@type string[]
local languages = { 'c', 'cpp', 'go', 'gomod',
  'gosum', 'lua', 'python', 'rust', 'vimdoc', 'vim', 'json', 'jsonc',
  'markdown', 'markdown_inline', 'racket', 'javascript', 'typescript',
  'query', 'scheme', 'fennel', 'bash', 'elixir', 'hyprlang', 'rasi', 'svelte',
  'zig', 'org', 'latex', 'ruby'
}

return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',

  build = ':TSUpdate',
  lazy = false,
  branch = 'main',
  -- This gets passed into the "Plugin.config()" value
  config = function()
    require('nvim-treesitter').install(languages)

    -- Enable highlights for files
    -- TODO: Ensure this works with languages like jsx
    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function()
        vim.treesitter.start()                                            -- Highlights
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indent
      end
    })
  end,

  dependencies = {
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
    -- Set rainbow delimiters
    {
      'hiphish/rainbow-delimiters.nvim',
      config = function()
        local rainbow_delimiters = require('rainbow-delimiters')
        -- Rainbow delimiters configuration
        vim.g.rainbow_delimiters = {
          strategy = {
            -- Global highlights every parenthesis,
            -- Local only highlights parenthesis you are near
            -- The '' is a base key to match with every lang
            [''] = rainbow_delimiters.strategy['global'],
          },
          query = {
            [''] = 'rainbow-delimiters',
            -- Highlights function blocks
            lua = 'rainbow-blocks',
          }

        }
      end
    },
  },
}
