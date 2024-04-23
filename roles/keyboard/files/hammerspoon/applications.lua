local globals = require("globals")

local function current_app()
  return hs.application.frontmostApplication():name()
end

hs.hotkey.bind({ "cmd" }, ";", function()
  -- hs.hotkey.bind(globals.hyper, "L", function()
  if current_app() == "WezTerm" then
    hs.application.launchOrFocus("Arc")
  else
    hs.application.launchOrFocus("WezTerm")
  end
end)

-- hs.hotkey.bind(globals.hyper, "K", function()
hs.hotkey.bind({ "cmd" }, "'", function()
  if current_app() == "Slack" then
    hs.application.launchOrFocus("Arc")
  else
    hs.application.launchOrFocus("Slack")
  end
end)

hs.hotkey.bind(globals.hyper, "J", function()
  hs.application.launchOrFocus("Obsidian")
end)

hs.hotkey.bind(globals.hyper, "H", function()
  hs.application.launchOrFocus("TickTick")
end)
