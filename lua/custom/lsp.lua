-- LSP Progress
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local data = ev.data
    local client = vim.lsp.get_client_by_id(data.client_id)
    local val = data.params.value
    local msg = string.format("%s: %s %s",
      client and client.name or "LSP",
      val.title or "",
      val.message or "")
    if val.percentage then
      msg = msg .. string.format(" (%d%%)", val.percentage)
    end
    vim.notify(msg, vim.log.levels.INFO)
  end,
})

-- LSP Keymaps
vim.keymap.set('n', 'grd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>os', ':checkhealth vim.lsp<cr>', { desc = "Open Server Info", silent = true })

-- LSP SERVER CONFIGURATION
local servers = {
  clangd = {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', '.git' },
  },
  gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.work', 'go.mod', '.git' },
  },
  basedpyright = {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
  },
  ruff = {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
    on_attach = function(client, _)
      client.server_capabilities.hoverProvider = false
    end,
  },
  rust_analyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
    settings = {
      ["rust-analyzer"] = {
        procMacro = { enable = true },
      },
    },
  },
  elixirls = {
    cmd = { 'elixir-ls' },
    filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
    root_markers = { 'mix.exs', '.git' },
    single_file_support = true,
  },
  sqlls = {
    cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
    filetypes = { 'sql', 'mysql' },
    root_markers = { '.sqllsrc.json', '.git' },
  },
  bashls = {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh', 'zsh' },
    root_markers = { '.git' },
  },
  zls = {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'zls.json', 'build.zig', '.git' },
  },
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml', 'stylua.toml', '.git' },
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  jsonls = {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    root_markers = { '.git' },
  },
  -- Web dev
  html = {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html', 'twig', 'hbs' },
    root_markers = { 'package.json', '.git' },
  },
  cssls = {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
  },
  ts_ls = {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  },
  tailwindcss = {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    filetypes = { 'html', 'css', 'scss', 'less', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'astro', 'templ', 'htmldjango', 'htmlangular', 'elixir', 'eelixir', 'heex', 'erb', 'eruby' },
    root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts', '.git' },
  },
  emmet_ls = {
    cmd = { 'emmet-ls', '--stdio' },
    filetypes = { 'astro', 'css', 'eruby', 'html', 'htmlangular', 'htmldjango', 'javascriptreact', 'less', 'pug', 'sass', 'scss', 'svelte', 'templ', 'typescriptreact', 'vue' },
    root_markers = { '.git' },
  },
  -- Go templating language
  templ = {
    cmd = { 'templ', 'lsp' },
    filetypes = { 'templ' },
    root_markers = { 'go.work', 'go.mod', '.git' },
  },
  -- Web frameworks
  svelte = {
    cmd = { 'svelteserver', '--stdio' },
    filetypes = { 'svelte' },
    root_markers = { 'package.json', '.git' },
  },
  astro = {
    cmd = { 'astro-ls', '--stdio' },
    filetypes = { 'astro' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  },
}

-- Add blink.cmp capabilities if available
local ok, blink = pcall(require, 'blink.cmp')
local capabilities = ok and blink.get_lsp_capabilities() or nil

for server_name, config in pairs(servers) do
  if capabilities then
    config.capabilities = capabilities
  end
  vim.lsp.config(server_name, config)
end
vim.lsp.enable(vim.tbl_keys(servers))

-- LSP Diagnostic Warnings Toggle
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>tw", function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config({
    virtual_text = isLspDiagnosticsVisible,
    underline = isLspDiagnosticsVisible,
  })
end, { desc = "Toggle Warnings", silent = true })
