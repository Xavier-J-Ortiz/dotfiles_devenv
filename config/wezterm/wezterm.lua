local wezterm = require("wezterm")

return {
	default_prog = { "bash", "-i" },
	font = wezterm.font("Mononoki Nerd Font Mono"),
	font_size = 11.0,

	color_scheme = "Dracula+",

	window_close_confirmation = "NeverPrompt",
	window_decorations = "TITLE | RESIZE",
	adjust_window_size_when_changing_font_size = false,

	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,

	-- Enable scrollback
	scrollback_lines = 10000,
}
