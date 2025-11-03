local wezterm = require("wezterm")

local config = wezterm.config_builder()

local keybindings = require("configs.keybindings")

config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.default_cursor_style = "BlinkingBar"
config.color_scheme = "Dracula (Official)"
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = 14
config.window_padding = {
	left = 3,
	right = 3,
	top = 0,
	bottom = 0,
}
config.background = {
	{
		source = {
			File = "/home/vicky/.config/wezterm/bg.png",
		},
		hsb = {
			hue = 1.0,
			saturation = 1.02,
			brightness = 0.25,
		},
	},
	{
		source = {
			Color = "#282A36",
		},
		width = "100%",
		height = "100%",
		opacity = 0.75,
	},
}
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)
config.keys = keybindings.keys

return config
