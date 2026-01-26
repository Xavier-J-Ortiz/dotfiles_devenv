require("mason-lspconfig").setup({
  ensure_installed = {
    'gopls',
    'basedpyright',
    'ruff',
    'lua_ls',
  }
})
