return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function()
		require("nvim-treesitter")
			.install({
				"lua",
				"vimdoc",
				"markdown",
				"python",
				"go",
				"bash",
			})
			:wait(300000)
	end,
	build = ":TSUpdate",
}
