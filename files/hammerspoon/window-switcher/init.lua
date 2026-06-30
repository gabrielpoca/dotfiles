-- window-switcher: a Cmd+Tab window switcher for Hammerspoon.
-- Visual style reused from https://github.com/anthonyfrisby/marv (no upstream license),
-- repurposed from an app launcher into a hold-Cmd / tap-Tab window switcher.

local M = {}

local WINDOW_WIDTH = 440
local WINDOW_HEIGHT = 500

local webview = nil
local windows = {}          -- ordered hs.window list for the current invocation
local selectedIndex = 1     -- 1-based index into `windows`
local isShowing = false
local iconCache = {}        -- bundleID -> icon data URI

-- All standard windows, across every Space.
local windowFilter = hs.window.filter.new():setCurrentSpace(nil)

-- Window ids in most-recently-focused order (most recent first). Maintained from
-- focus events so the switcher list is ordered by recency.
local mru = {}

local function mruForget(id)
    for index, existing in ipairs(mru) do
        if existing == id then
            table.remove(mru, index)
            return
        end
    end
end

local function mruBump(win)
    local id = win and win:id()
    if not id then return end
    mruForget(id)
    table.insert(mru, 1, id)
end

local function mruRemove(win)
    local id = win and win:id()
    if id then mruForget(id) end
end

local function mruRank(id)
    for index, existing in ipairs(mru) do
        if existing == id then return index end
    end
    return math.huge
end

local function getModulePath()
    local info = debug.getinfo(1, "S")
    return info.source:match("^@(.*/)")
end

local function appIconForWindow(win)
    local app = win:application()
    if not app then return nil end
    local bundleID = app:bundleID()
    if bundleID and iconCache[bundleID] ~= nil then
        return iconCache[bundleID]
    end

    local uri = false  -- cache misses as `false` so we don't re-resolve every open
    local icon = bundleID and hs.image.imageFromAppBundle(bundleID) or nil
    if icon then
        uri = icon:size({ w = 32, h = 32 }):encodeAsURLString()
    end
    if bundleID then iconCache[bundleID] = uri end
    return uri or nil
end

-- Capture the window list, frontmost first, so Cmd+Tab lands on the previous window.
-- Only keep real, visible app windows: not minimized, app not hidden, and a
-- standard window (drops menu-bar popovers/panels like MacWhisper's helper window).
local function refreshWindows()
    windows = {}
    for _, win in ipairs(windowFilter:getWindows()) do
        if win:isVisible() and win:isStandard() then
            table.insert(windows, win)
        end
    end

    table.sort(windows, function(left, right)
        return mruRank(left:id()) < mruRank(right:id())
    end)

    local focused = hs.window.focusedWindow()
    if focused then
        for index, win in ipairs(windows) do
            if win:id() == focused:id() then
                if index ~= 1 then
                    table.remove(windows, index)
                    table.insert(windows, 1, focused)
                end
                break
            end
        end
    end
end

local function buildRows()
    local rows = {}
    for _, win in ipairs(windows) do
        local app = win:application()
        table.insert(rows, {
            app = app and app:name() or "",
            title = win:title() or "",
            icon = appIconForWindow(win),
        })
    end
    return rows
end

local function renderSelection()
    if webview then
        webview:evaluateJavaScript(string.format("setSelection(%d);", selectedIndex - 1))
    end
end

local function showSwitcher(direction)
    if not webview then return end
    refreshWindows()
    local count = #windows
    if count == 0 then return end

    local frame = hs.screen.mainScreen():frame()
    webview:frame({
        x = frame.x + (frame.w - WINDOW_WIDTH) / 2,
        y = frame.y + (frame.h - WINDOW_HEIGHT) / 3,
        w = WINDOW_WIDTH,
        h = WINDOW_HEIGHT,
    })

    webview:evaluateJavaScript(string.format("initWindows(%s);", hs.json.encode(buildRows())))

    -- First press skips the current window (index 1).
    selectedIndex = direction > 0 and math.min(2, count) or count

    webview:show()
    webview:bringToFront(true)
    isShowing = true
    renderSelection()
end

local function advance(direction)
    local count = #windows
    if count == 0 then return end
    selectedIndex = ((selectedIndex - 1 + direction) % count) + 1
    renderSelection()
end

local function commit()
    isShowing = false
    if webview then webview:hide() end
    local win = windows[selectedIndex]
    if win then win:focus() end
end

local function cancel()
    isShowing = false
    if webview then webview:hide() end
end

-- Click-to-pick from the list.
local function handleMessage(message)
    if not message or not message.body then return end
    local body = message.body
    if body.action == "select" and body.index ~= nil then
        selectedIndex = body.index + 1
        commit()
    end
end

local function createWebview()
    local file = io.open(getModulePath() .. "ui.html", "r")
    if not file then
        hs.alert.show("window-switcher: could not load ui.html")
        return
    end
    local html = file:read("*a")
    file:close()

    local controller = hs.webview.usercontent.new("hammerspoon")
    controller:setCallback(handleMessage)

    webview = hs.webview.new(
        { x = 0, y = 0, w = WINDOW_WIDTH, h = WINDOW_HEIGHT },
        { developerExtrasEnabled = false },
        controller
    )

    webview:windowStyle({ "borderless" })
    webview:level(hs.drawing.windowLevels.floating)
    webview:allowTextEntry(false)
    webview:transparent(true)
    webview:html(html)
    webview:allowGestures(false)
    webview:allowNewWindows(false)
    webview:behaviorAsLabels({ "moveToActiveSpace" })
    webview:windowTitle("window-switcher")
    webview:deleteOnClose(false)
end

local keyTap = nil
local flagTap = nil

local function init()
    createWebview()

    -- Maintain recency order from focus events; drop windows when they close.
    windowFilter:subscribe(hs.window.filter.windowFocused, mruBump)
    windowFilter:subscribe(hs.window.filter.windowDestroyed, mruRemove)

    -- Seed from current front-to-back order (frontmost ends up most-recent).
    local ordered = hs.window.orderedWindows()
    for index = #ordered, 1, -1 do
        mruBump(ordered[index])
    end

    -- Cmd+Tab is system-reserved, so hs.hotkey/Carbon can't override it.
    -- Consume the key event here so the native app switcher never appears.
    keyTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
        local flags = event:getFlags()
        local code = event:getKeyCode()

        if code == hs.keycodes.map.tab and flags.cmd
            and not flags.alt and not flags.ctrl and not flags.fn then
            local direction = flags.shift and -1 or 1
            if isShowing then advance(direction) else showSwitcher(direction) end
            return true
        end

        if isShowing and code == hs.keycodes.map.escape then
            cancel()
            return true
        end

        return false
    end)
    keyTap:start()

    -- Commit the selection when Cmd is released (mirrors the native switcher).
    flagTap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
        if isShowing and not event:getFlags().cmd then
            commit()
        end
        return false
    end)
    flagTap:start()

    -- Keep references so the eventtaps survive garbage collection across reloads.
    M.keyTap = keyTap
    M.flagTap = flagTap
    M.webview = webview

    hs.alert.show("window-switcher: Cmd+Tab window switcher ready")
end

init()

return M
