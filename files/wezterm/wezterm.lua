require("utils")

local wezterm = require("wezterm")
local act = wezterm.action
local theme = require("theme")
local projects = require("projects")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local font = "InconsolataGo Nerd Font Mono"

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

config.audible_bell = "Disabled"
config.tab_max_width = 30
config.font = wezterm.font(font)
config.font_rules = {
  {
    intensity = "Normal",
    italic = false,
    font = wezterm.font({
      family = font,
      weight = "Regular",
    }),
  },
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font({
      family = font,
      weight = "Bold",
      style = "Normal",
    }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font({
      family = font,
      weight = "Bold",
      style = "Italic",
    }),
  },
}
config.font_size = 17.0
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.enable_scroll_bar = false
config.window_decorations = "RESIZE"
config.inactive_pane_hsb = {
  saturation = 0.70,
  brightness = 1.00,
  -- saturation = 0.90,
  -- brightness = 0.90,
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 10,
}

local function isViProcess(pane)
  return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if isViProcess(pane) then
    window:perform_action(
    -- This should match the keybinds you set in Neovim.
      act.SendKey({ key = vim_direction, mods = "CTRL" }),
      pane
    )
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
  conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
  conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
  conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
  conditionalActivatePane(window, pane, "Down", "j")
end)

config.command_palette_font_size = 16.0

local url_regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}(:[\\d]+)?\\S*\\b"
local ip_addr_regex = "\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\b"

config.quick_select_patterns = {
  url_regex,
  ip_addr_regex,
  [['[^']*']],
  [["[^"]*"]],
  "[A-Za-z0-9-_.]{4,100}",
}

config.hyperlink_rules = {
  {
    regex = url_regex,
    format = "$0",
  },
  {
    regex = ip_addr_regex,
    format = "$0",
  },
}

local copy_mode = wezterm.gui.default_key_tables().copy_mode

table.insert(copy_mode, {
  key = "/",
  mods = "NONE",
  action = act.Multiple({
    act.CopyMode("ClearPattern"),
    act.Search("CurrentSelectionOrEmptyString"),
  }),
})

table.insert(copy_mode, { key = "i", mods = "NONE", action = act.CopyMode("Close") })
table.insert(copy_mode, { key = "n", mods = "NONE", action = act.CopyMode("NextMatch") })
table.insert(copy_mode, { key = "N", mods = "NONE", action = act.CopyMode("PriorMatch") })

table.insert(copy_mode, {
  key = "Escape",
  mods = "NONE",
  action = act.Multiple({
    act.ClearSelection,
    act.CopyMode("ClearPattern"),
    act.CopyMode("ClearSelectionMode"),
  }),
})

local search_mode = wezterm.gui.default_key_tables().search_mode

table.insert(search_mode, {
  key = "Enter",
  mods = "NONE",
  action = act.Multiple({
    act.CopyMode("ClearSelectionMode"),
    act.ActivateCopyMode,
  }),
})

table.insert(search_mode, { key = "Escape", mods = "NONE", action = act.CopyMode("Close") })
table.insert(search_mode, { key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") })
table.insert(search_mode, { key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") })

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)

  -- if tab.is_active then
  return {
    -- { Background = { Color = "blue" } },
    { Text = " " .. title .. " " },
  }
  -- end

  -- return title
end)

wezterm.on("update-right-status", function(window, pane)
  window:set_right_status(" " .. window:active_workspace() .. " ")
end)

config.key_tables = {
  copy_mode = copy_mode,
  search_mode = search_mode,
}

config.keys = {
  {
    mods = "CMD",
    key = "i",
    action = wezterm.action_callback(function(window, pane)
      projects.open_workspace(window, pane)
    end),
  },
  {
    mods = "CMD",
    key = "u",
    action = wezterm.action_callback(function(window, pane)
      projects.open_pane(window, pane)
    end),
  },
  {
    key = "j",
    mods = "CMD",
    action = wezterm.action_callback(function(_, pane)
      local tab = pane:tab()
      local panes = tab:panes_with_info()
      if #panes == 1 then
        pane:split({
          direction = "Bottom",
          size = 0.4,
        })
      elseif not panes[1].is_zoomed then
        panes[1].pane:activate()
        tab:set_zoomed(true)
      elseif panes[1].is_zoomed then
        tab:set_zoomed(false)
        panes[2].pane:activate()
      end
    end),
  },
  { key = "h", mods = "CMD",        action = act.ActivateTabRelative(-1) },
  { key = "l", mods = "CMD",        action = act.ActivateTabRelative(1) },
  { key = "h", mods = "CTRL",       action = act.EmitEvent("ActivatePaneDirection-left") },
  { key = "j", mods = "CTRL",       action = act.EmitEvent("ActivatePaneDirection-down") },
  { key = "k", mods = "CTRL",       action = act.EmitEvent("ActivatePaneDirection-up") },
  { key = "l", mods = "CTRL",       action = act.EmitEvent("ActivatePaneDirection-right") },
  { key = "p", mods = "CMD",        action = act.ActivateCommandPalette },
  { key = "f", mods = "CMD",        action = act.QuickSelect },
  { key = "x", mods = "CMD",        action = act.ActivateCopyMode },
  { key = "s", mods = "CMD",        action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
  { key = "w", mods = "CMD",        action = act.CloseCurrentPane({ confirm = true }) },
  { key = "f", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "v", mods = "CMD",        action = act.PasteFrom("Clipboard") },
  {
    key = "c",
    mods = "CMD",
    action = wezterm.action_callback(function(window, pane)
      local name = window:active_tab():get_title()

      window:perform_action(
        act.SpawnCommandInNewTab({
          domain = "DefaultDomain",
        }),
        pane
      )

      window:active_tab():set_title(name)
    end),
  },
  {
    key = "o",
    mods = "CMD",
    action = act.RotatePanes("Clockwise"),
  },
  {
    key = "r",
    mods = "CMD",
    action = wezterm.action_callback(function()
      wezterm.reload_configuration()
    end),
  },
  {
    key = "z",
    mods = "CMD",
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = "e",
    mods = "CMD",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, _pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
}

return object_assign(config, theme)
