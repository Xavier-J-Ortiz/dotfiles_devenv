-- LSP-specific optimizations
return {
	lsp = {
		jump1 = true,
		async_or_timeout = 5000,
		timeout = 30000,
	},
	-- Global fzf-lua settings
	fzf_opts = {
		["--ansi"] = true,
		["--info"] = "inline-right",
		["--height"] = "100%",
		["--layout"] = "reverse",
		["--border"] = "none",
		["--highlight-line"] = true,
	},
	-- Window settings
	winopts = {
		height = 0.85,
		width = 0.80,
		border = "rounded",
	},
	-- Fast minimal previews (can enhance later)
	previewer = "builtin",
	file_icons = true,
	git_icons = false,
}
