return {
	"neovim/nvim-lspconfig",
	config = function()
		-- TODO: after evaluating what stays in `config.lsp`, maybe also point to a `config.nvim-lspconfig`
		require("config.lsp")
	end,
}
