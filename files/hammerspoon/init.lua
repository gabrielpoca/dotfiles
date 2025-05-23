require("window_placement")
require("string")

hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("AwesomeKeys")
hs.loadSpoon("BingDaily")

spoon.ReloadConfiguration:start()
spoon.BingDaily:init()

local keys = spoon.AwesomeKeys

keys:remapAppKeys({
  app = "Zen",
  keys = {
    { from = { mods = { "command" }, key = "j" }, to = { mods = { "ctrl" }, key = "tab" } },
    { from = { mods = { "command" }, key = "k" }, to = { mods = { "ctrl", "shift" }, key = "tab" } },
    { from = { mods = { "command" }, key = "h" }, to = { mods = { "ctrl", "shift" }, key = "h" } },
    { from = { mods = { "command" }, key = "l" }, to = { mods = { "ctrl", "shift" }, key = "l" } },
  },
})

local HeadphoneAutoPause = hs.loadSpoon("HeadphoneAutoPause")
HeadphoneAutoPause:start()

-- https://spinscale.de/posts/2016-11-08-creating-a-productive-osx-environment-hammerspoon.html
function handleCaffeinateEvents(eventType)
  if eventType == hs.caffeinate.watcher.systemDidWake then
    -- mute sound on wake
    local output = hs.audiodevice.defaultOutputDevice()
    output:setMuted(true)
  end
end

caffeinateWatcher = hs.caffeinate.watcher.new(handleCaffeinateEvents)
caffeinateWatcher:start()

function applicationWatcher(appName, eventType, appObject)
  if eventType == hs.application.watcher.launched then
    if appName == "Music" then
      appObject:kill()
    end
  end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
