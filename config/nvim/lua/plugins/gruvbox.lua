return {
	"ellisonleao/gruvbox.nvim",
	opts = {
		terminal_colors = true, -- add neovim terminal colors
		undercurl = true,
		underline = true,
		bold = true,
		italic = {
			strings = true,
			emphasis = true,
			comments = true,
			operators = false,
			folds = true,
		},
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		inverse = true, -- invert background for search, diffs, statuslines and errors
		contrast = "", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = false,
		transparent_mode = false,
	},
	priority = 1000,
	config = function(_, opts)
		require("gruvbox").setup(opts)
		vim.o.background = "dark" -- or "light" for light mode
		vim.cmd("colorscheme gruvbox")
	end,
}
