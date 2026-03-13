local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local M = {}

local project_root = os.getenv("HOME") .. "/Developer/"

local function get_projects()
  local projects = { { id = project_root, label = "default" } }

  for _, project in ipairs(wezterm.glob("*", project_root)) do
    table.insert(projects, {
      id = project_root .. project,
      label = project,
    })
  end

  return projects
end

local function pick(label, window, pane, callback)
  window:perform_action(
    act.InputSelector({
      action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
        if not id and not label then
          wezterm.log_info("cancelled")
        else
          callback(id, label)
        end
      end),
      choices = get_projects(),
      fuzzy = true,
      fuzzy_description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Text = " " .. label .. ": " },
      }),
    }),
    pane
  )
end

M.open_workspace = function(window, pane)
  pick("Workspace", window, pane, function(folder, label)
    window:perform_action(
      act.SwitchToWorkspace({
        name = label,
        spawn = {
          label = "Workspace: " .. label,
          cwd = folder,
        },
      }),
      pane
    )

    wezterm.reload_configuration()
    -- window:active_tab():set_title(label)
  end)
end

M.open_pane = function(window, pane)
  pick("Pane", window, pane, function(folder, label)
    window:perform_action(
      act.SpawnCommandInNewTab({
        cwd = folder,
        domain = "DefaultDomain",
      }),
      pane
    )

    wezterm.reload_configuration()
    window:active_tab():set_title(label)
  end)
end

return M
