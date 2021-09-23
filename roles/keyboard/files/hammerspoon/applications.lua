globals = require "globals"

function current_app()
  return hs.application.frontmostApplication():name()
end

-- open chrome
hs.hotkey.bind(globals.hyper, "L", function()
  if current_app() == "Brave Browser" then
    hs.application.launchOrFocus("Alacritty")
  else
    hs.application.launchOrFocus("Brave Browser")
  end
end)

-- open Alacritty
--hs.hotkey.bind(globals.hyper, "L", function()
  --hs.application.launchOrFocus("Alacritty")
--end)

-- open slack
hs.hotkey.bind(globals.hyper, ";", function()
  print(hs.inspect.inspect(hs.application.runningApplications()))
  --hs.application.launchOrFocus("Slack")
end)

