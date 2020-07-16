globals = require "globals"

-- open chrome
hs.hotkey.bind(globals.shift_hyper, "J", function()
  hs.application.launchOrFocus("Firefox")
end)

-- open iTerm
hs.hotkey.bind(globals.shift_hyper, "K", function()
  hs.application.launchOrFocus("iTerm")
end)

-- open notedown
hs.hotkey.bind(globals.shift_hyper, ";", function()
  hs.application.launchOrFocus("NoteDown")
end)

-- open slack
hs.hotkey.bind(globals.shift_hyper, "L", function()
  hs.application.launchOrFocus("Slack")
end)

