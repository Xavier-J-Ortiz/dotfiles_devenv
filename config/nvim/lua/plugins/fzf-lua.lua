return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		-- Primary goto definitions
		{ "gd", "<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>", desc = "Goto Definition" },
		{ "gD", "<cmd>FzfLua lsp_declarations<cr>", desc = "Goto Declaration" },
		{ "gr", "<cmd>FzfLua lsp_references<cr>", desc = "Goto References" },
		{ "gi", "<cmd>FzfLua lsp_implementations<cr>", desc = "Goto Implementation" },
		-- Symbol navigation
		{ "<leader>cw", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
		-- Research mode (alternative to trouble.nvim LSP)
		{ "<leader>cl", "<cmd>FzfLua lsp_finder<cr>", desc = "LSP All Locations" },
	},
	opts = require("config.fzf-lua"),
}
