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

function checkBluetoothResult(rc, stderr, stderr)
    if rc ~= 0 then
        print(string.format("Unexpected result executing `blueutil`: rc=%d stderr=%s stdout=%s", rc, stderr, stdout))
    end
end

function bluetooth(power)
    print("Setting bluetooth to " .. power)
    local t = hs.task.new("/usr/local/bin/blueutil", checkBluetoothResult, {"--power", power})
    t:start()
end

--https://spinscale.de/posts/2016-11-08-creating-a-productive-osx-environment-hammerspoon.html
function handleCaffeinateEvents(eventType)
  if (eventType == hs.caffeinate.watcher.systemDidWake) then
    --mute
    local output = hs.audiodevice.defaultOutputDevice()
    output:setMuted(true)
  elseif eventType == hs.caffeinate.watcher.systemWillSleep then
    bluetooth("off")
  elseif eventType == hs.caffeinate.watcher.screensDidWake then
    bluetooth("on")
  end
end

caffeinateWatcher = hs.caffeinate.watcher.new(handleCaffeinateEvents)
caffeinateWatcher:start()
