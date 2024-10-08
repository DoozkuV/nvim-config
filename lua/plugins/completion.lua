-- Global variable to enable/disable completion
vim.g.cmp_toggle_flag = true
-- Plugins relating to completion in nvim
local otter_ft = { 'markdown', 'html', 'nix' }
return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',

    -- Adds completion to the cmdline
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',

    -- Enables LSP Inside of Codeblocks
    {
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
    },

  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    -- Tab down and up functions for use later in the config
    local tab_down = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' })

    local tab_up = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' })

    local tab_down_cmdline = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end

    local tab_up_cmdline = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- Enable or disable completion
      enabled = function()
        return vim.g.cmp_toggle_flag
      end,
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<C-j>'] = tab_down,
        ['<Tab>'] = tab_down,
        ['<C-k>'] = tab_up,
        ['<S-Tab>'] = tab_up,
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        -- Commented this out as well - see neorg.lua
        -- { name = 'neorg' },
        { name = 'otter' },
        { name = 'lazydev', group_index = 0 }
      },
    }

    -- '/' cmdline setup
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline({
        -- ['<C-n>'] = cmp.mapping.select_next_item(),
        -- ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete {},
        -- ['<CR>'] = cmp.mapping.confirm {
        --   behavior = cmp.ConfirmBehavior.Replace,
        --   select = true,
        -- },
        ['<C-j>'] = { c = tab_down_cmdline },
        ['<Tab>'] = { c = tab_down_cmdline },
        ['<C-k>'] = { c = tab_up_cmdline },
        ['<S-Tab>'] = { c = tab_up_cmdline },
      }),
      sources = {
        { name = 'buffer' }
      }
    })

    -- `:` cmdline setup
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline({
        -- ['<C-n>'] = cmp.mapping.select_next_item(),
        -- ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete {},
        -- ['<CR>'] = cmp.mapping.confirm {
        --   behavior = cmp.ConfirmBehavior.Replace,
        --   select = true,
        -- },
        ['<C-j>'] = { c = tab_down_cmdline },
        ['<Tab>'] = { c = tab_down_cmdline },
        ['<C-k>'] = { c = tab_up_cmdline },
        ['<S-Tab>'] = { c = tab_up_cmdline },
      }),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })
  end,
  keys = {
    { -- Toggle completion binding
      '<leader>tc',
      function()
        vim.g.cmp_toggle_flag = not vim.g.cmp_toggle_flag
        print("Completion "
          .. (vim.g.cmp_toggle_flag and "enabled" or "disabled"))
      end,
      desc = '[T]oggle [C]ompletion',
    }
  },
}
