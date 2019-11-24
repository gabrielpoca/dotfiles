hyper = {"cmd","alt","ctrl"}
shift_hyper = {"cmd","alt","ctrl","shift"}

hs.window.animationDuration = 0

function placeWindow(x, y, w, h)
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = x
  f.y = y
  f.w = w
  f.h = h

  win:setFrame(f)
end
function screenFrame()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  return screen:frame()
end

hs.hotkey.bind(shift_hyper, "Y", function()
  local max = screenFrame()
  placeWindow(max.x, max.y, max.w / 2, max.h)
end)

hs.hotkey.bind(shift_hyper, "O", function()
  local max = screenFrame()
  placeWindow(max.x + (max.w / 2), max.y, max.w / 2, max.h)
end)

hs.hotkey.bind(shift_hyper, "U", function()
  local max = screenFrame()
  placeWindow(max.x, max.y, max.w, max.h)
end)

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind(hyper, ";", function()
  hs.application.launchOrFocus("Brave Browser")
end)

hs.hotkey.bind(hyper, "\'", function()
  hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind(hyper, "\\", function()
  hs.application.launchOrFocus("Visual Studio Code")
end)

local Caffeine = hs.loadSpoon('Caffeine')
Caffeine:start()

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