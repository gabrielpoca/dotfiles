globals = require "globals"

function current_app() return hs.application.frontmostApplication():name() end

hs.hotkey.bind(globals.hyper, "L", function()
    if current_app() == "Alacritty" then
        hs.application.launchOrFocus("Brave Browser")
    else
        hs.application.launchOrFocus("Alacritty")
    end
end)

hs.hotkey.bind(globals.hyper, "K", function()
    if current_app() == "Slack" then
        hs.application.launchOrFocus("Discord")
    else
        hs.application.launchOrFocus("Slack")
    end
end)

hs.hotkey.bind(globals.hyper, "J", function()
    if current_app() == "Obsidian" then
        hs.application.launchOrFocus("TickTick")
    else
        hs.application.launchOrFocus("Obsidian")
    end
end)
