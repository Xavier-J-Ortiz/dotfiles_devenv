-- use this or tiny-inline-diagnostic
return {
	"dgagn/diagflow.nvim",
	event = "LspAttach", -- This is what I use personnally and it works great
	opts = require("config.diagflow"),
	enabled = false,
}
