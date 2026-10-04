globals = require("globals")

hs.window.animationDuration = 0

local last_position

function place_window(x, y, w, h, win)
  win = win or hs.window.focusedWindow()
  if not win then return end
  local f = win:frame()

  f.x = x
  f.y = y
  f.w = w
  f.h = h

  win:setFrame(f)
end

function screen_frame(win)
  win = win or hs.window.focusedWindow()
  if not win then return end
  local screen = win:screen()
  if not screen then return end
  local frame = screen:frame()
  local full_frame = screen:fullFrame()

  return { x = frame.x, y = frame.y, w = frame.w, h = full_frame.h }
end

function place_left_half(win)
  win = win or hs.window.focusedWindow()
  if not win then return end
  local frame = screen_frame(win)
  if not frame then return end
  local window_width = frame.w / 2

  if last_position == "left" then
    window_width = frame.w / 5 * 3
    last_position = "big_left"
  else
    last_position = "left"
  end

  place_window(frame.x, 0, window_width, frame.h, win)
end

function place_right_half(win)
  win = win or hs.window.focusedWindow()
  if not win then return end
  local frame = screen_frame(win)
  if not frame then return end
  local window_width = frame.w / 2

  if last_position == "right" then
    window_width = frame.w / 5 * 3
    last_position = "big_right"
  else
    last_position = "right"
  end

  place_window(frame.w - window_width + frame.x, 0, window_width, frame.h, win)
end

function place_full(win)
  win = win or hs.window.focusedWindow()
  if not win then return end
  local frame = screen_frame(win)
  if not frame then return end
  local x_offset = 0
  place_window(frame.x + x_offset, frame.y, frame.w - x_offset, frame.h, win)
  last_position = "full"
end

function place_center(win)
  win = win or hs.window.focusedWindow()
  if not win then return end
  local frame = screen_frame(win)
  if not frame then return end
  local width = frame.w / 8 * 7
  local height = frame.h / 8 * 7
  place_window(frame.x + (frame.w - width) / 2, frame.y + (frame.h - height) / 2, width, height, win)
  last_position = "center"
end

function on_application(name, callback)
  hs.window.filter
      .new({ name })
      :setAppFilter(name, {
        allowTitles = 1,
        hasTitlebar = true,
      })
      :subscribe(hs.window.filter.windowCreated, function(win)
        -- A new window may belong to a background app; never use focus here.
        if win then callback(win) end
      end)
end

hs.hotkey.bind(globals.hyper, "Y", place_left_half)
hs.hotkey.bind(globals.hyper, "O", place_right_half)
hs.hotkey.bind(globals.hyper, "U", place_full)

on_application("Obsidian", place_full)
on_application("Telegram", place_right_half)
on_application("Arc", place_full)
on_application("Calendar", place_full)
on_application("Figma", place_full)
on_application("Slack", place_full)
on_application("Visual Studio Code", place_full)
on_application("Cursor", place_full)
on_application("WezTerm", place_full)
