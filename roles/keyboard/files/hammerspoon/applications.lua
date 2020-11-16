globals = require "globals"

-- open chrome
hs.hotkey.bind(globals.hyper, "J", function()
  hs.application.launchOrFocus("Firefox Developer Edition")
end)

-- open Alacritty
hs.hotkey.bind(globals.hyper, "K", function()
  hs.application.launchOrFocus("Alacritty")
end)

-- open notedown
hs.hotkey.bind(globals.hyper, ";", function()
  hs.application.launchOrFocus("NoteDown")
end)

-- open slack
hs.hotkey.bind(globals.hyper, "L", function()
  hs.application.launchOrFocus("Slack")
end)

