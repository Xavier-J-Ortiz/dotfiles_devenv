require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
	ensure_installed = { "lua", "vimdoc", "markdown", "python", "go" },
	highlight = {
		enable = true,
	},
})
-- wait required so that there is no error when bootstrapping plugins on first run.
require("nvim-treesitter").install({ "lua", "vimdoc", "markdown", "python", "go" }):wait(300000)
