return {
	"folke/snacks.nvim",
	opts = {
		input = {},
		terminal = {
			enabled = true,
		},
		picker = {
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
}
