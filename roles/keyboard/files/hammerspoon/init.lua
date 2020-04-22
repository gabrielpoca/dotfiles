require "window_placement"
require "applications"
require "search"

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local Caffeine = hs.loadSpoon('Caffeine')
Caffeine:start()
Caffeine:setDisplay(true)

local HeadphoneAutoPause = hs.loadSpoon('HeadphoneAutoPause')
HeadphoneAutoPause:start()

--https://spinscale.de/posts/2016-11-08-creating-a-productive-osx-environment-hammerspoon.html
function muteOnWake(eventType)
  if (eventType == hs.caffeinate.watcher.systemDidWake) then
    local output = hs.audiodevice.defaultOutputDevice()
    output:setMuted(true)
  end
end

caffeinateWatcher = hs.caffeinate.watcher.new(muteOnWake)
caffeinateWatcher:start()
