local globals = require "globals"

local function current_app() return hs.application.frontmostApplication():name() end

hs.hotkey.bind(globals.hyper, "L", function()
    if current_app() == "Alacritty" then
        hs.application.launchOrFocus("Brave Browser")
    else
        hs.application.launchOrFocus("Alacritty")
    end
end)

hs.hotkey.bind(globals.hyper, "K",
               function() hs.application.launchOrFocus("Slack") end)

hs.hotkey.bind(globals.hyper, "J",
               function() hs.application.launchOrFocus("Obsidian") end)

hs.hotkey.bind(globals.hyper, "H",
               function() hs.application.launchOrFocus("TickTick") end)

