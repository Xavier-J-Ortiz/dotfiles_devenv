return {
	"NickvanDyke/opencode.nvim",
	version = "*", -- Latest stable release
	dependencies = {
		{
			-- `snacks.nvim` integration is recommended, but optional
			---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
			"folke/snacks.nvim",
			opts = {
				input = {}, -- Enhances `ask()`
				terminal = {
					-- If explicitly set to true, enables the _nvim_ integrated terminal, and not any of the
					-- other terminal integrations.
					-- If not present, or false, the integrated terminal takes precedence.
					enabled = true,
				},
				picker = { -- Enhances `select()`
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
			},
		},
	},
	config = function()
		require("config.opencode")
	end,
}
