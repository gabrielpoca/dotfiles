globals = require "globals"

-- open chrome
hs.hotkey.bind(globals.shift_hyper, "J", function()
  hs.application.launchOrFocus("Google Chrome")
end)

-- open iTerm
hs.hotkey.bind(globals.shift_hyper, "K", function()
  hs.application.launchOrFocus("iTerm")
end)

-- open slack
hs.hotkey.bind(globals.shift_hyper, "L", function()
  hs.application.launchOrFocus("Slack")
end)

