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
  },
  cmd = "Telescope",
  ft = 'mason',
  keys = {

    {
      '<leader>sr',
      function() require('telescope.builtin').oldfiles() end,
      desc =
      '[S]earch [R]ecently opened files'
    },
    { '<leader>,',  function() require('telescope.builtin').buffers() end,    desc = '[,] Find existing buffers' },
    {
      '<leader>/',
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = '[/] Fuzzily search in current buffer'
    },
    { '<leader>gf', function() require('telescope.builtin').git_files() end,  desc = 'Search [G]it [F]iles' },
    { '<leader> ',  function() require('telescope.builtin').find_files() end, desc = '[ ] Find Files' },
    { '<leader>sh', function() require('telescope.builtin').help_tags() end,  desc = '[S]earch [H]elp' },
    { '<leader>sw', function()
      require('telescope.builtin').grep_string()
    end, { desc = '[S]earch current [W]ord' } },
    { '<leader>sg', function() require('telescope.builtin').live_grep() end,      desc = '[S]earch by [G]rep' },
    {
      '<leader>sd',
      function() require('telescope.builtin').diagnostics() end,
      desc =
      '[S]earch [D]iagnostics'
    },
    { '<leader>sf', function() require('telescope.builtin').find_files() end,     desc = '[S]earch [F]iles' },

    { '<leader>sm', function() require('telescope.builtin').man_pages() end,      desc = '[S]earch [M]an' },

    -- LSP Keybinds
    { 'gr',         function() require('telescope.builtin').lsp_references() end, desc = '[G]oto [R]eferences' },
    {
      '<leader>ds',
      function() require('telescope.builtin').lsp_document_symbols() end,

      desc =
      '[D]ocument [S]ymbols'
    },
    {
      '<leader>ws',
      function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,

      desc =
      '[W]orkspace [S]ymbols'
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
    }
    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
    -- NOTE: Telescope bindings moved to 'keymaps.lua'
  end,
}
