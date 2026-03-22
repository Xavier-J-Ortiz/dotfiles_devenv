return {
	"NickvanDyke/opencode.nvim",
	version = "*",
	dependencies = { "folke/snacks.nvim" },
	config = function()
		require("config.opencode")
	end,
}
