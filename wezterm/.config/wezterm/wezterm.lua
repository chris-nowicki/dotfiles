local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	window_background_opacity = 0.9,
	macos_window_background_blur = 10,
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},
	initial_rows = 30,
	initial_cols = 110,
	default_cursor_style = "BlinkingBar",
	font = wezterm.font("MesloLGS Nerd Font Mono"),
	font_size = 16,
	color_scheme = "Catppuccin Mocha"
}

return config