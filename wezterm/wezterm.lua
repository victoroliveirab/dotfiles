local wezterm = require("wezterm")
local action = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = "Dracula (Official)"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 12
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.enable_scroll_bar = false
-- See more: https://wezfurlong.org/wezterm/config/lua/config/freetype_load_target.html
config.freetype_load_target = "Light"

-- In order to make Option key to modify on MacOS
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- config.launch_menu = {
-- { label = "top", args = "top" },
-- { label = "list", args = { "ls", "-alt" } },
-- }

config.keys = {
	{
		key = "t",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "\\",
		mods = "LEADER",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "l",
		mods = "LEADER",
		action = action.ActivatePaneDirection("Right"),
	},
	{
		key = "h",
		mods = "LEADER",
		action = action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = action.ActivatePaneDirection("Up"),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = action.ActivateTab(i - 1),
	})
end

config:set_strict_mode(true)

return config
