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
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

local HOST_ICON = {
  mac = wezterm.nerdfonts.dev_apple,
  linux = wezterm.nerdfonts.dev_linux,
  remote = wezterm.nerdfonts.md_server,
}

local function cwd_host(pane)
  local cwd = pane.current_working_dir
  if not cwd then
    return nil
  end

  if type(cwd) == "userdata" and cwd.host then
    return cwd.host
  end

  local cwd_string = tostring(cwd)
  return cwd_string:match("^%w+://([^/:]+)")
end

local function pane_host(pane)
  local host = cwd_host(pane)
  if host and host ~= "" and host ~= "local" and host ~= "localhost" then
    return host
  end

  if pane.domain_name and pane.domain_name ~= "" and pane.domain_name ~= "local" then
    return pane.domain_name
  end

  return wezterm.hostname() or host or "local"
end

local function host_info(pane)
  local host = pane_host(pane)
  local short = host:gsub("%..*$", "")
  local hl = short:lower()
  local kind

  if hl:find("mac") or hl:find("darwin") then
    kind = "mac"
  elseif hl == "local" or hl == "localhost" then
    kind = "remote"
  else
    kind = "linux"
  end

  return kind, short
end

local function tab_title(tab)
  if tab.tab_title and #tab.tab_title > 0 then
    return tab.tab_title
  end

  local kind, name = host_info(tab.active_pane)
  return string.format("%s  %s", HOST_ICON[kind], name)
end

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
  return {
    { Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
    { Text = "  " .. tab_title(tab) .. "  " },
  }
end)

local url_regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}(:[\\d]+)?\\S*\\b"
local ip_addr_regex = "\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\b"

config.quick_select_patterns = {
  url_regex,
  ip_addr_regex,
  [['[^']*']],
  [["[^"]*"]],
  "[A-Za-z0-9-_.]{4,100}",
}

-- Remote multiplexing into mantis (Zed-style): wezterm-mux-server holds the
-- terminal grid on mantis and this GUI renders it locally. Connect with
-- `wezterm connect mantis`. Both ends run the same pinned-nixpkgs wezterm so the
-- mux codec versions match.
local REMOTE_HOST = "mantis"
local REMOTE_DIR = "/tmp/wezterm-clip"

config.ssh_domains = {
  {
    name = REMOTE_HOST,
    remote_address = REMOTE_HOST,
    username = "gabriel",
    multiplexing = "WezTerm",
    remote_wezterm_path = "/run/current-system/sw/bin/wezterm",
    -- mantis is in Hetzner Germany (~53ms RTT from here). The default
    -- threshold is 100ms, so predictive echo never engages and every keystroke
    -- waits a full round-trip. Lowering it below 53ms turns on mosh-style local
    -- echo so typing feels instant.
    local_echo_threshold_ms = 10,
  },
}

local function clipboard_has_image()
  local ok, out = wezterm.run_child_process({ "osascript", "-e", "clipboard info" })
  return ok and out ~= nil and out:find("PNGf") ~= nil
end

local function save_clipboard_png(local_path)
  local script = string.format(
    'set f to (open for access POSIX file "%s" with write permission)\n'
      .. "try\n"
      .. "  write (the clipboard as «class PNGf») to f\n"
      .. "end try\n"
      .. "close access f",
    local_path
  )
  return wezterm.run_child_process({ "osascript", "-e", script })
end

-- Cmd+V on a mantis pane holding a clipboard image: save it on the Mac, ship it
-- to mantis, and insert the remote path so Claude Code can Read it. Otherwise a
-- normal clipboard paste.
local function smart_paste(window, pane)
  local domain = pane:get_domain_name() or ""
  if domain:find(REMOTE_HOST) and clipboard_has_image() then
    local stamp = string.format("%d-%d", os.time(), pane:pane_id())
    local tmp = os.getenv("TMPDIR") or "/tmp"
    local local_png = string.format("%s/wezterm-clip-%s.png", tmp, stamp)
    local remote_png = string.format("%s/paste-%s.png", REMOTE_DIR, stamp)
    local saved = save_clipboard_png(local_png)
    local made = wezterm.run_child_process({ "ssh", REMOTE_HOST, "mkdir -p " .. REMOTE_DIR })
    local sent = wezterm.run_child_process({ "scp", "-q", local_png, REMOTE_HOST .. ":" .. remote_png })
    if saved and made and sent then
      window:perform_action(act.SendString(remote_png), pane)
      return
    end
    window:toast_notification("WezTerm", "clipboard image paste to " .. REMOTE_HOST .. " failed", nil, 4000)
  end
  window:perform_action(act.PasteFrom("Clipboard"), pane)
end

-- Send CSI-u Alt+<key> for Cmd+<key> so tmux can disambiguate from bare Esc + key
local function alt_csi_u(letter)
  return act.SendString(string.format("\x1b[%d;3u", string.byte(letter)))
end

config.keys = {
  { key = "v", mods = "CMD", action = wezterm.action_callback(smart_paste) },
  { key = "c", mods = "CMD", action = alt_csi_u("c") },
  { key = "h", mods = "CMD", action = alt_csi_u("h") },
  { key = "k", mods = "CMD", action = alt_csi_u("k") },
  { key = "l", mods = "CMD", action = alt_csi_u("l") },
  { key = "s", mods = "CMD", action = alt_csi_u("s") },
  { key = "j", mods = "CMD", action = alt_csi_u("j") },
  { key = "w", mods = "CMD", action = alt_csi_u("w") },
  { key = "z", mods = "CMD", action = alt_csi_u("z") },
  { key = "x", mods = "CMD", action = alt_csi_u("x") },
  { key = "e", mods = "CMD", action = alt_csi_u("e") },
  { key = "i", mods = "CMD", action = alt_csi_u("i") },
  { key = "y", mods = "CMD", action = alt_csi_u("y") },
  { key = "o", mods = "CMD", action = alt_csi_u("o") },
  { key = "f", mods = "CMD", action = act.QuickSelect },
  { key = "u", mods = "CMD", action = alt_csi_u("u") },
  { key = "r", mods = "CMD", action = alt_csi_u("r") },
  { key = "d", mods = "CMD", action = alt_csi_u("d") },
  { key = "g", mods = "CMD", action = alt_csi_u("g") },
  { key = "n", mods = "CMD", action = alt_csi_u("n") },

  { key = "t", mods = "CMD", action = alt_csi_u("t") },

  -- WezTerm native: new tab and splits
  { key = "n", mods = "CMD|SHIFT", action = act.SpawnWindow },
  -- Always local, so opening a mantis tab doesn't make every later new tab
  -- inherit the mantis domain. Mantis is reached only via Cmd+Shift+M below.
  { key = "t", mods = "CMD|SHIFT", action = act.SpawnTab({ DomainName = "local" }) },
  -- Attach the mantis mux domain as a tab in the current window (no second GUI
  -- process, so no phantom local window like `wezterm connect` produces).
  { key = "m", mods = "CMD|SHIFT", action = act.SpawnTab({ DomainName = REMOTE_HOST }) },
  { key = "d", mods = "CMD|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "e", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "w", mods = "CMD|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },
}

config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- Notifications from remote sessions via SetUserVar
wezterm.on("user-var-changed", function(window, pane, name, value)
  if name == "notify" then
    window:toast_notification("Claude", value, nil, 4000)
  end
end)

for k, v in pairs(theme) do
  config[k] = v
end

return config
