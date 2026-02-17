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
		"shellcheck", -- bash
		"codespell", -- check spelling in code
		"markdownlint-cli2", -- markdown
		-- formatters
		"gofumpt", -- golang
		"goimports", -- golang
		"stylua", -- lua
		"shfmt", -- bash
		"prettier", -- markdown
		-- LSPs
		"gopls", -- golang
		"lua_ls", -- lua
		"bash-language-server", -- bash
		"marksman", -- markdown
		"ty", -- python typechecker
	},
})
