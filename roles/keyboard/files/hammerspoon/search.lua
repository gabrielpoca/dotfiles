globals = require "globals"

local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

local function urlencode(url)
  if url == nil then
    return
  end
  url = url:gsub("\n", "\r\n")
  url = url:gsub("([^%w ])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

-- search google
hs.hotkey.bind(globals.hyper, "j", function()
  local frame = hs.window.focusedWindow():screen():frame()

  pos_x = frame.x / 2
  pos_y = frame.y / 2

  hs.focus()
  local button, value = hs.dialog.textPrompt("Search in Startpage", "", "", "Search", "Cancel")
  if button == 'Search' then
    hs.execute("open https://www.startpage.com/do/dsearch?query=" .. urlencode(value))
  end
end)
