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

config.enable_kitty_keyboard = true
config.disable_default_key_bindings = true

config.default_prog = { "/bin/zsh", "-lc", "zellij attach --create default" }

local send = function(key, mods)
  return act.SendKey({ key = key, mods = mods })
end

config.keys = {
  { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
  {
    key = "c",
    mods = "CMD",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("Clipboard"), pane)
      else
        window:perform_action(send("c", "ALT"), pane)
      end
    end),
  },
  { key = "s", mods = "CMD", action = send("s", "ALT") },
  { key = "j", mods = "CMD", action = send("j", "ALT") },
  { key = "h", mods = "CMD", action = send("h", "ALT") },
  { key = "l", mods = "CMD", action = send("l", "ALT") },
  { key = "w", mods = "CMD", action = send("w", "ALT") },
  { key = "z", mods = "CMD", action = send("z", "ALT") },
  { key = "o", mods = "CMD", action = send("o", "ALT") },
  { key = "e", mods = "CMD", action = send("e", "ALT") },
  { key = "x", mods = "CMD", action = send("x", "ALT") },
  { key = "y", mods = "CMD", action = send("y", "ALT") },
  { key = "f", mods = "CMD", action = act.QuickSelect },
  { key = "r", mods = "CMD", action = act.ReloadConfiguration },
}

for k, v in pairs(theme) do
  config[k] = v
end

return config
