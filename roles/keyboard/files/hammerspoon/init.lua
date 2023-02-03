require "window_placement"
require "applications"
require "string"

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local Caffeine = hs.loadSpoon('Caffeine')
Caffeine:start()
Caffeine:setDisplay(true)

local HeadphoneAutoPause = hs.loadSpoon('HeadphoneAutoPause')
HeadphoneAutoPause:start()

-- https://spinscale.de/posts/2016-11-08-creating-a-productive-osx-environment-hammerspoon.html
function handleCaffeinateEvents(eventType)
    if (eventType == hs.caffeinate.watcher.systemDidWake) then
        local output = hs.audiodevice.defaultOutputDevice()
        output:setMuted(true)
    end
end

caffeinateWatcher = hs.caffeinate.watcher.new(handleCaffeinateEvents)
caffeinateWatcher:start()

-- Mouse thumb rest
-- https://tom-henderson.github.io/2018/12/14/hammerspoon.html
hs.hotkey.bind({"alt", "ctrl"}, "Tab", function()
    hs.application.launchOrFocus("Mission Control.app")
end)

-- Automatically close Music app when it opens
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.launched) then
        if (appName == "Music") then appObject:kill() end
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
