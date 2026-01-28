require("mason-tool-installer").setup({
	enabled = true,
	-- Add linters and formatters only. LSPs are installed in the `mason-lspconfig` config.
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	ensure_installed = {
		-- linters
		"golangci-lint", -- golang
		"ruff", -- python linter & formatter
		"luacheck", -- lua
		-- formatters
		"ty", -- python typechecker that complements `ruff`
		"gofumpt", -- golang
		"goimports", -- golang
		"isort", -- python
		"stylua", -- lua
		-- LSPs formerly referenced in `mason-lspconfig`, to be used in in `lsp` config.
		"gopls", -- golang
		"basedpyright", -- python
		"lua_ls", -- lua
		-- check spelling in code
		"codespell",
	},
})
