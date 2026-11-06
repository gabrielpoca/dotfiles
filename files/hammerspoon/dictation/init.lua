-- Cmd+. toggles local dictation. The worker owns audio; Hammerspoon owns UI/paste.
local M = { phase = "idle", serial = 0, ready = false, text = "" }
local base = hs.configdir .. "/dictation/"
local python = os.getenv("HOME") .. "/.local/share/hammerspoon-dictation/venv/bin/python"
local log = hs.logger.new("dictation", "info")
local escape, panel, worker, pendingStart, target, focusedElement
local buffer, errors = "", ""

local function preview(_, _text)
  local states = {
    loading = {"Loading model…", {red=0.95, green=0.7, blue=0.25}},
    starting = {"Opening microphone…", {red=0.95, green=0.7, blue=0.25}},
    recording = {"Recording · ⌘. to finish", {red=1, green=0.3, blue=0.3}},
    finalizing = {"Transcribing…", {red=0.4, green=0.7, blue=1}},
    cancelling = {"Cancelling…", {white=0.6}},
    result = {"Ready · ⌘. to paste", {red=0.4, green=0.85, blue=0.55}},
  }
  local state = states[M.phase] or states.loading
  if not panel then
    local window = hs.window.focusedWindow()
    local screen = window and window:screen() or hs.screen.mainScreen()
    local frame = screen:frame()
    panel = hs.canvas.new({x=frame.x + (frame.w-240)/2,
      y=frame.y + frame.h-58, w=240, h=38})
    panel:level(hs.canvas.windowLevels.overlay)
    panel:behavior({"canJoinAllSpaces", "fullScreenAuxiliary"})
    panel:appendElements(
      {type="rectangle", action="fill", roundedRectRadii={xRadius=19,yRadius=19},
       fillColor={white=0.08,alpha=0.94}},
      {type="circle", action="fill", center={x=20,y=19}, radius=5,
       fillColor=state[2]},
      {type="text", text=state[1], textSize=13, textColor={white=0.95},
       frame={x=35,y=9,w=195,h=22}})
  end
  panel[2].fillColor = state[2]
  panel[3].text = state[1]
  panel:show()
end

local function reset()
  M.phase, M.text, pendingStart = "idle", "", false
  target, focusedElement = nil, nil
  escape:disable()
  if panel then panel:delete(); panel = nil end
end

local function send(op)
  if worker and worker:isRunning() then
    worker:setInput(hs.json.encode({op=op, id=M.serial}) .. "\n")
  end
end

local function focus()
  local ok, element = pcall(function()
    return hs.axuielement.systemWideElement():attributeValue("AXFocusedUIElement")
  end)
  return ok and element or nil
end

local function paste(text)
  if text == "" then reset(); hs.alert.show("No speech detected"); return end
  if hs.eventtap.isSecureInputEnabled() then
    M.phase, M.text = "result", text
    preview("Secure input active · focus a text field, then ⌘. · Esc cancels", text)
    return
  end
  local saved = hs.pasteboard.readAllData()
  if not hs.pasteboard.setContents(text) then
    M.phase, M.text = "result", text
    preview("Clipboard unavailable · ⌘. retries · Esc cancels", text)
    return
  end
  local count = hs.pasteboard.changeCount()
  hs.eventtap.keyStroke({"cmd"}, "v", 0)
  hs.timer.doAfter(1, function()
    -- Never overwrite something the user copied after our paste.
    if hs.pasteboard.changeCount() == count then
      if saved then hs.pasteboard.writeAllData(saved) else hs.pasteboard.clearContents() end
    end
  end)
  reset()
end

local function startRecording()
  pendingStart = false
  M.phase = "starting"
  send("start")
  preview("Opening microphone · ⌘. or Esc cancels", "")
end

local function message(event)
  if event.type == "ready" then
    M.ready = true
    if pendingStart then startRecording() end
    return
  end
  if event.type == "fatal" then
    log.e(event.message or "Worker failed")
    reset()
    hs.alert.show("Dictation: " .. (event.message or "worker failed"), 6)
    return
  end
  if event.id ~= M.serial then return end
  if event.type == "cancelled" then reset(); return end
  if event.type == "error" then
    reset()
    hs.alert.show("Dictation: " .. event.message, 6)
    return
  end
  if M.phase == "cancelling" then
    if event.type == "final" then reset() end
    return
  end
  if event.type == "recording" then
    M.phase = "recording"
    preview("● Listening · ⌘. finishes · Esc cancels", "")
  elseif event.type == "limit" then
    target, focusedElement = hs.window.focusedWindow(), focus()
    M.phase = "finalizing"
    preview("Three-minute limit reached · Finalizing… · Esc cancels", M.text)
  elseif event.type == "finalizing" then
    M.phase = "finalizing"
    preview("Finalizing locally… · Esc cancels", M.text)
  elseif event.type == "final" then
    local current = hs.window.focusedWindow()
    local element = focus()
    if target and current and current:id() == target:id()
      and (not focusedElement or element == focusedElement) then
      paste(event.text)
    else
      M.phase, M.text = "result", event.text
      hs.alert.show("Transcript ready — focus a text field and press ⌘.", 3)
      preview("Transcript ready · focus a text field, then ⌘. to paste · Esc cancels", M.text)
    end
  end
end

local function ensureWorker()
  if worker and worker:isRunning() then return true end
  if not hs.fs.attributes(python) then
    hs.alert.show("Run hammerspoon-dictation-setup first", 5)
    return false
  end
  buffer, errors, M.ready = "", "", false
  worker = hs.task.new(python, function(code)
    worker, M.ready = nil, false
    if M.phase ~= "idle" then
      reset()
      hs.alert.show("Dictation helper stopped. Press ⌘. to retry.", 5)
    end
    if code ~= 0 then log.e("Worker exited " .. code .. ": " .. errors) end
  end, function(_, stdout, stderr)
    errors = (errors .. (stderr or "")):sub(-2000)
    buffer = buffer .. (stdout or "")
    while true do
      local pos = buffer:find("\n", 1, true)
      if not pos then break end
      local line = buffer:sub(1, pos-1)
      buffer = buffer:sub(pos+1)
      local ok, event = pcall(hs.json.decode, line)
      if ok and type(event) == "table" then message(event) end
    end
    return true
  end, {"-B", "-u", base .. "helper.py"})
  if not worker:start() then worker = nil; return false end
  return true
end

function M.cancel()
  if M.phase == "idle" then return end
  if M.phase == "loading" or M.phase == "result" then reset(); return end
  M.phase = "cancelling"
  send("cancel")
  preview("Cancelling…", "")
end

function M.toggle()
  if M.phase == "recording" then
    target, focusedElement = hs.window.focusedWindow(), focus()
    M.phase = "finalizing"
    send("stop")
    preview("Finalizing locally… · Esc cancels", M.text)
  elseif M.phase == "result" then
    paste(M.text)
  elseif M.phase == "starting" or M.phase == "loading" then
    M.cancel()
  elseif M.phase == "idle" then
    if hs.eventtap.isSecureInputEnabled() then
      hs.alert.show("Leave the secure input field before dictating")
      return
    end
    M.serial, M.text = M.serial + 1, ""
    M.phase, pendingStart = "loading", true
    escape:enable()
    preview("Loading local model… · ⌘. or Esc cancels", "")
    if not ensureWorker() then reset(); return end
    if M.ready then startRecording() end
  end
end

escape = hs.hotkey.new({}, "escape", M.cancel)
M.hotkey = hs.hotkey.bind({"cmd"}, ".", M.toggle)
local previousShutdown = hs.shutdownCallback
hs.shutdownCallback = function()
  if worker and worker:isRunning() then
    send("cancel")
    worker:closeInput()
    worker:terminate()
  end
  if previousShutdown then previousShutdown() end
end
return M
