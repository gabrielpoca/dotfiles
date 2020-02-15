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

-- place window on the left half of the screen
hs.hotkey.bind(globals.shift_hyper, "Y", place_left_half)

-- place window on the right half of the screen
hs.hotkey.bind(globals.shift_hyper, "O", place_right_half)

-- make window take the whole screen
hs.hotkey.bind(globals.shift_hyper, "U", place_full)

-- slack full screen
hs.window.filter.new{'Slack'}:setAppFilter('Slack',{allowTitles=1; hasTitlebar=true}):subscribe(hs.window.filter.windowCreated, function()
  place_full()
end)

-- telegram right half
hs.window.filter.new{'Telegram'}:setAppFilter('Telegram',{allowTitles=1; hasTitlebar=true}):subscribe(hs.window.filter.windowCreated, function()
  place_right_half()
end)

-- iterm full screen
hs.window.filter.new{'iTerm2'}:setAppFilter('iTerm2',{allowTitles=1; hasTitlebar=true}):subscribe(hs.window.filter.windowCreated, function()
  place_full()
end)

-- brave full screen
hs.window.filter.new{'Brave Browser'}:setAppFilter('Brave Browser',{allowTitles=1; hasTitlebar=true}):subscribe(hs.window.filter.windowCreated, function()
  place_full()
end)

-- insomnia full screen
hs.window.filter.new{'Insomnia'}:setAppFilter('Insomnia',{allowTitles=1; hasTitlebar=true}):subscribe(hs.window.filter.windowCreated, function()
  place_full()
end)

-- calendar full screen
hs.window.filter.new{'Calendar'}:setAppFilter('Calendar',{allowTitles=1; hasTitlebar=true}):subscribe(hs.window.filter.windowCreated, function()
  place_full()
end)
