-- See also obsidian.lua for more markdown stuff
return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      initial_state = false,
    },
  }

  -- { -- Image support for neorg and markdown
  --   "3rd/image.nvim",
  --   ft = { "markdown", "norg" },
  --   config = function()
  --     -- Append magick to package directory
  --     require("image").setup()
  --   end,
  --   opts = {
  --     backend = "ueberzug",
  --     integrations = {
  --       markdown = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { "markdown" }, -- markdown extensions (ie. quarto) can go here
  --       },
  --       neorg = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { "norg" },
  --       },
  --     },
  --     max_width = nil,
  --     max_height = nil,
  --     max_width_window_percentage = nil,
  --     max_height_window_percentage = 50,
  --     window_overlap_clear_enabled = false,                                                     -- toggles images when windows are overlapped
  --     window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  --     editor_only_render_when_focused = false,                                                  -- auto show/hide images when the editor gains/looses focus
  --     tmux_show_only_in_active_window = false,                                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  --     hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.excalidraw" }, -- render image files as images when opened
  --   },
  -- }
}
