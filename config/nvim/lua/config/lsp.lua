-- TODO: Rethink if some of this config is better suited living within a plugin
-- i.e. FzfLua keybinding in fzf-lua.lua config file, vim stuff moved to vim-opts.lua
--
-- Enhanced capabilities for blink.cmp integration
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Setup on_attach with diagnostic keymappings only
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  
  -- Hover (still useful for quick info)
  -- Moving this to `init.lua` would be great, but currently breaks `neo-tree` toggle button
  vim.keymap.set('n', 'K', '<cmd>FzfLua lsp_hover<cr>', bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, bufopts)
end

-- Server configurations with your priorities
local servers = {
  -- TODO: `markdown` server config missing??
  gopls = {},
  basedpyright = {
    settings = {
      analysis = {
        typeCheckingMode = "standard",
      },
    },
  },
  ruff = {
    -- Ruff as linter/formatter only
    init_options = {
      settings = {
        -- Any ruff-specific settings
      }
    }
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  },
}
local lspconfig = {}
-- Setup all servers using original, working lspconfig API
for server, config in pairs(servers) do
  -- lspconfig[server].setup({
    lspconfig[server] = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = config.settings or {},
    init_options = config.init_options or {},
  }
end

vim.lsp.config('lspconfig', lspconfig)
vim.lsp.enable('lspconfig')

