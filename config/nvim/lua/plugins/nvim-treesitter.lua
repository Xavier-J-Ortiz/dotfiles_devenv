return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function()
		require("config.nvim-treesitter")
	end,
	build = ":TSUpdate",
}
