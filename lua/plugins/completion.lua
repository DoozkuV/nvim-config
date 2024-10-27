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

    -- Cool little icons
    'onsails/lspkind.nvim',
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    -- See `:help cmp`
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}
    local lspkind = require('lspkind')


    -- Create an autocommand to enable completion in all buffers except telescope
    vim.api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
      callback = function()
        if vim.bo.filetype ~= "TelescopePrompt" and vim.b.cmp_enabled == nil then
          vim.b.cmp_enabled = true
        end
      end
    })

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

    local base_keybind_table = {
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      ['<Tab>'] = tab_down,
      ['<S-Tab>'] = tab_up,
    }

    local command_keybind_table = {
      ['<C-j>'] = { c = tab_down_cmdline },
      ['<Tab>'] = { c = tab_down_cmdline },
      ['<C-k>'] = { c = tab_up_cmdline },
      ['<S-Tab>'] = { c = tab_up_cmdline },
    }

    cmp.setup {
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
          show_labelDetails = true,
        })
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- Enable or disable completion
      enabled = function()
        return vim.b.cmp_enabled
      end,
      -- Add the tab bindings
      mapping = cmp.mapping.preset.insert(base_keybind_table),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'lazydev', group_index = 0 },
        { name = 'path' },
        { name = 'buffer' },
      },
    }

    -- '/' cmdline setup
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(command_keybind_table),
      sources = {
        { name = 'buffer' }
      }
    })

    -- `:` cmdline setup
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(command_keybind_table),
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
        vim.b.cmp_enabled = not vim.b.cmp_enabled
        print("Completion "
          .. (vim.b.cmp_enabled and "enabled" or "disabled"))
      end,
      desc = 'Toggle Completion',
    }
  },
}
