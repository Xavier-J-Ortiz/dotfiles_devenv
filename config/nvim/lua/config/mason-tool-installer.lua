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
		"vale", -- markdown
		"markdownlint-cli2", -- markdown
		"shellcheck", -- bash
		-- formatters
		"ty", -- python typechecker that complements `ruff`
		"gofumpt", -- golang
		"goimports", -- golang
		"isort", -- python
		"stylua", -- lua
		"shfmt", -- bash
		-- LSPs formerly referenced in `mason-lspconfig`, to be used in in `lsp` config.
		"gopls", -- golang
		"basedpyright", -- python
		"lua_ls", -- lua
		"bash-language-server", -- bash
		-- check spelling in code
		"codespell",
	},
})
