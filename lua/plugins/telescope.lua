return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim'
  },
  -- Gen keybind is for integration with the LLM Dropdown.
  cmd = { "Telescope", "Gen" },
  ft = 'mason',
  keys = {

    {
      '<leader>sr',
      function() require('telescope.builtin').oldfiles() end,
      desc =
      'Search Recently opened files'
    },
    {
      '<leader>,',
      function() require('telescope.builtin').buffers() end,
      desc = 'Find existing buffers'
    },
    {
      '<leader>/',
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = 'Fuzzily search in current buffer'
    },
    { '<leader>gf', function() require('telescope.builtin').git_files() end,  desc = 'Search Git Files' },
    { '<leader> ',  function() require('telescope.builtin').find_files() end, desc = 'Find Files' },
    { '<leader>sh', function() require('telescope.builtin').help_tags() end,  desc = 'Search Help' },
    {
      '<leader>sw',
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = 'Search current Word'
    },
    { '<leader>sg', function() require('telescope.builtin').live_grep() end,  desc = 'Search by Grep' },
    {
      '<leader>sd',
      function() require('telescope.builtin').diagnostics() end,
      desc =
      'Search Diagnostics'
    },
    { '<leader>sf', function() require('telescope.builtin').find_files() end, desc = 'Search Files' },
    { '<leader>sb', function() require('telescope.builtin').buffers() end,    desc = 'Search Buffers' },

    { '<leader>sm', function() require('telescope.builtin').man_pages() end,  desc = 'Search Man' },

    -- LSP Keybinds
    -- { 'gr',         function() require('telescope.builtin').lsp_references() end, desc = 'Goto References' },
    {
      '<leader>ds',
      function() require('telescope.builtin').lsp_document_symbols() end,
      desc = 'Document Symbols',
    },
    {
      '<leader>ws',
      function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
      desc = 'Workspace Symbols',
    },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<C-j>'] = {
              require('telescope.actions').move_selection_next, type = "action",
              opts = { nowait = true, silent = true }
            },
            ['<C-k>'] = {
              require('telescope.actions').move_selection_previous, type = "action",
              opts = { nowait = true, silent = true }
            }
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        }
      }
    }
    -- Enable extensions, if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    -- NOTE: Telescope bindings moved to 'keymaps.lua'
  end,
}
