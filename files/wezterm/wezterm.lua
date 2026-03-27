local wezterm = require("wezterm")
local act = wezterm.action
local theme = require("theme")

local config = wezterm.config_builder()

config.font = wezterm.font("Maple Mono NF")
config.font_size = 15.0
config.max_fps = 120
config.animation_fps = 120
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.window_background_opacity = 0.96
config.audible_bell = "Disabled"
config.notification_handling = "AlwaysShow"
config.window_decorations = "RESIZE"
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }


local url_regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}(:[\\d]+)?\\S*\\b"
local ip_addr_regex = "\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\b"

config.quick_select_patterns = {
  url_regex,
  ip_addr_regex,
  [['[^']*']],
  [["[^"]*"]],
  "[A-Za-z0-9-_.]{4,100}",
}

config.keys = {
  { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
  { key = "c", mods = "CMD", action = act.SendKey({ key = "c", mods = "ALT" }) },
  { key = "h", mods = "CMD", action = act.SendKey({ key = "h", mods = "ALT" }) },
  { key = "l", mods = "CMD", action = act.SendKey({ key = "l", mods = "ALT" }) },
  { key = "s", mods = "CMD", action = act.SendKey({ key = "s", mods = "ALT" }) },
  { key = "j", mods = "CMD", action = act.SendKey({ key = "j", mods = "ALT" }) },
  { key = "w", mods = "CMD", action = act.SendKey({ key = "w", mods = "ALT" }) },
  { key = "z", mods = "CMD", action = act.SendKey({ key = "z", mods = "ALT" }) },
  { key = "x", mods = "CMD", action = act.SendKey({ key = "x", mods = "ALT" }) },
  { key = "e", mods = "CMD", action = act.SendKey({ key = "e", mods = "ALT" }) },
  { key = "i", mods = "CMD", action = act.SendKey({ key = "i", mods = "ALT" }) },
  { key = "y", mods = "CMD", action = act.SendKey({ key = "y", mods = "ALT" }) },
  { key = "o", mods = "CMD", action = act.SendKey({ key = "o", mods = "ALT" }) },
  { key = "f", mods = "CMD", action = act.QuickSelect },
  { key = "u", mods = "CMD", action = act.SendKey({ key = "u", mods = "ALT" }) },
  { key = "r", mods = "CMD", action = act.SendKey({ key = "r", mods = "ALT" }) },
  { key = "d", mods = "CMD", action = act.SendKey({ key = "d", mods = "ALT" }) },
  { key = "q", mods = "CMD", action = act.DisableDefaultAssignment },
}

config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

for k, v in pairs(theme) do
  config[k] = v
end

return config
