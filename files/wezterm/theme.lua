local wezterm = require("wezterm")
local act = wezterm.action
local astrodark = require("colors/astrodark")
local astrolight = require("colors/astrolight")

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "astrodark"
  else
    return "astrolight"
  end
end

local function update_theme(window)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)

  -- if overrides.color_scheme ~= scheme then
  --   wezterm.log_info("updating theme to " .. scheme)
  overrides.color_scheme = scheme
  window:set_config_overrides(overrides)
  -- end
end

wezterm.on("window-config-reloaded", function(window, _pane)
  update_theme(window)
end)

-- Add handler for system appearance changes
wezterm.on("window-system-appearance-changed", function(window)
  update_theme(window)
end)

return {
  color_schemes = {
    ["astrodark"] = astrodark.colors(),
    ["astrolight"] = astrolight.colors(),
  },
}
