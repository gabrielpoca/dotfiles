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
  local frame = screen:frame()
  local full_frame = screen:fullFrame()

  return {
    x = frame.x,
    y = frame.y,
    w = frame.w,
    h = full_frame.h
  }
end

function place_left_half()
  local frame = screenFrame()
  placeWindow(frame.x, 0, frame.w / 2, frame.h)
end

function place_right_half()
  local frame = screenFrame()
  placeWindow(frame.w / 2 + frame.x, 0, frame.w / 2, frame.h)
end

function place_full()
  local frame = screenFrame()
  placeWindow(frame.x, frame.y, frame.w, frame.h)
end

function place_center()
  local frame = screenFrame()
  local width = frame.w / 8 * 7
  local height = frame.h / 8 * 7
  placeWindow(frame.x + (frame.w - width) / 2, frame.y + (frame.h - height) / 2, width, height)
end

function on_application(name, callback)
  hs.window.filter.new{name}:setAppFilter(name,{allowTitles=1; hasTitlebar=true}):subscribe(hs.window.filter.windowCreated, callback)
end

-- place window on the left half of the screen
hs.hotkey.bind(globals.hyper, "Y", place_left_half)
-- place window on the right half of the screen
hs.hotkey.bind(globals.hyper, "O", place_right_half)
-- make window take the whole screen
hs.hotkey.bind(globals.hyper, "U", place_full)

-- slack full screen
on_application('Slack', place_full)
-- telegram right half
on_application('Telegram', place_right_half)
-- alacritty full screen
on_application('Alacritty', place_full)
-- vscode full screen
on_application('Visual Studio Code', place_full)
-- brave full screen
--on_application('Brave Browser', place_full)
-- firefox full screen
on_application('Firefox', place_full)
-- chrome full screen
on_application('Google Chrome', place_full)
-- insomnia full screen
on_application('Insomnia', place_full)
-- calendar full screen
on_application('Calendar', place_full)
-- figma
on_application('Figma', place_full)
-- mac pass
on_application('MacPass', place_center)
-- notedown
on_application('NoteDown', place_center)
-- todoist
on_application('Todoist', place_right_half)
