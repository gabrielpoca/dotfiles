globals = require "globals"

hs.window.animationDuration = 0

local window_gap = 0

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

function place_left_half()
  local max = screenFrame()
  placeWindow(window_gap / 2, window_gap / 2, max.w / 2 - (window_gap / 2), max.h - window_gap)
end

function place_right_half()
  local max = screenFrame()
  placeWindow(max.w / 2 + (window_gap / 2), window_gap / 2, max.w / 2 - window_gap, max.h - window_gap)
end

function place_full()
  local max = screenFrame()
  placeWindow(max.x + window_gap / 2, max.y + window_gap / 2, max.w - window_gap, max.h - window_gap)
end

function on_application(name, callback)
  hs.window.filter.new{name}:setAppFilter(name,{allowTitles=1; hasTitlebar=true}):subscribe(hs.window.filter.windowCreated, callback)
end

-- place window on the left half of the screen
hs.hotkey.bind(globals.shift_hyper, "Y", place_left_half)
-- place window on the right half of the screen
hs.hotkey.bind(globals.shift_hyper, "O", place_right_half)
-- make window take the whole screen
hs.hotkey.bind(globals.shift_hyper, "U", place_full)

-- slack full screen
on_application('Slack', place_full)
-- telegram right half
on_application('Telegram', place_right_half)
-- iterm full screen
on_application('iTerm2', place_full)
-- vscode full screen
on_application('Visual Studio Code', place_full)
-- brave full screen
on_application('Brave Browser', place_full)
-- chrome full screen
on_application('Google Chrome', place_full)
-- insomnia full screen
on_application('Insomnia', place_full)
-- calendar full screen
on_application('Calendar', place_full)
-- figma
on_application('Figma', place_full)
-- todoist
on_application('Todoist', place_right_half)