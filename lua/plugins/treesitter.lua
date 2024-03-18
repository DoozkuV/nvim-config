-- Stores all the filetypes to be supported by treesitter
local supported_languages = { 'c', 'cpp', 'go', 'gomod',
  'gosum', 'lua', 'python', 'rust', 'vimdoc', 'vim', 'json',
  'markdown', 'markdown_inline', 'racket', 'javascript', 'query' }

return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
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

  build = ':TSUpdate',
  -- Filetypes
  ft = supported_languages,
  -- This gets passed into the "Plugin.config()" value
  config = function()
    require('nvim-treesitter.configs').setup {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = supported_languages,

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = true,

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    }
  end,
}
