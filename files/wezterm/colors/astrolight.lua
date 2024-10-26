local M = {}

local c = {
  none = "NONE",
  syntax = {},
  ui = {},
  term = {},
}

--------------------------------
--- Syntax
--------------------------------
c.syntax.red = "#990000"
c.syntax.blue = "#00508A"
c.syntax.green = "#345E00"
c.syntax.yellow = "#7300B8"
c.syntax.purple = "#9E007C"
c.syntax.cyan = "#00615B"
c.syntax.orange = "#A34500"
c.syntax.comment = "#8B9297"
c.syntax.text = "#4F4F4F"

--------------------------------
--- UI
--------------------------------
c.ui.red = "#E72F1F"
c.ui.blue = "#3F8CEA"
c.ui.green = "#42AD17"
c.ui.yellow = "#E69400"
c.ui.purple = "#671FF0"
c.ui.cyan = "#21B386"
c.ui.orange = "#F0740A"

c.ui.accent = c.ui.purple

c.ui.tabline = "#E1E2E4"
c.ui.winbar = "#999FA3"
c.ui.tool = "#F0F0F1"
c.ui.base = "#F7F8F8"
c.ui.inactive_base = "#EAEBEB"
c.ui.statusline = "#E1E2E4"
c.ui.split = "#E8E9EA"
c.ui.float = "#E1E2E3"
c.ui.title = c.ui.accent
c.ui.border = c.ui.accent
c.ui.current_line = "#EAEBEB"
c.ui.scrollbar = c.ui.accent
c.ui.selection = "#E7E9EB"
-- TODO: combine menu_selection and selection
c.ui.menu_selection = c.ui.selection
c.ui.highlight = "#DADBDD"
c.ui.none_text = "#B5B9BD"
c.ui.text = "#737474"
c.ui.text_active = "#424446"
c.ui.text_inactive = "#AEB3B6"
c.ui.text_match = "#17191C"

c.ui.prompt = "#F0F0F1"

--------------------------------
--- Terminal
--------------------------------
c.term.black = c.ui.tabline
c.term.bright_black = c.ui.base

c.term.red = c.syntax.red
c.term.bright_red = c.syntax.red

c.term.green = c.syntax.green
c.term.bright_green = c.syntax.green

c.term.yellow = c.syntax.yellow
c.term.bright_yellow = c.syntax.yellow

c.term.blue = c.syntax.blue
c.term.bright_blue = c.syntax.blue

c.term.purple = c.syntax.purple
c.term.bright_purple = c.syntax.purple

c.term.cyan = c.syntax.cyan
c.term.bright_cyan = c.syntax.cyan

c.term.white = c.syntax.text
c.term.bright_white = c.syntax.text

c.term.background = c.ui.base
c.term.foreground = c.ui.text

-------------------------------
--- Wezterm
--------------------------------

local active_tab = {
  bg_color = c.ui.base,
  fg_color = c.ui.text_active,
}

local inactive_tab = {
  bg_color = c.ui.tabline,
  fg_color = c.ui.text_inactive,
}

function M.colors()
  return {
    foreground = c.ui.text,
    background = c.term.background,
    cursor_bg = c.ui.text,
    cursor_border = c.ui.text,
    cursor_fg = c.ui.black,
    selection_bg = c.ui.selection,
    selection_fg = c.ui.text_active,
    scrollbar_thumb = c.ui.winbar,

    ansi = {
      c.term.black,
      c.term.red,
      c.term.green,
      c.term.yellow,
      c.term.blue,
      c.term.purple,
      c.term.cyan,
      c.term.white,
    },

    brights = {
      c.term.bright_black,
      c.term.bright_red,
      c.term.bright_green,
      c.term.bright_yellow,
      c.term.bright_blue,
      c.term.bright_purple,
      c.term.bright_cyan,
      c.term.bright_white,
    },

    tab_bar = {
      background = c.ui.tabline,
      active_tab = active_tab,
      inactive_tab = inactive_tab,
      inactive_tab_hover = active_tab,
      new_tab = inactive_tab,
      new_tab_hover = active_tab,
      inactive_tab_edge = c.ui.none_text,
    },
  }
end

function M.window_frame() -- (Fancy tab bar only)
  return {
    active_titlebar_bg = active_tab.bg_color,
    inactive_titlebar_bg = inactive_tab.bg_color,
  }
end

return M
