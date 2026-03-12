local M = {}

-- get the os name {"mac" or "linux" or "win"}
function M.get_os()
  local os
  if vim.fn.has "mac" == 1 then
    os = "mac"
  elseif vim.fn.has "unix" == 1 then
    os = "linux"
    if vim.fn.has "wsl" == 1 then os = os .. "-wsl" end
  elseif vim.fn.has "win32" == 1 then
    os = "win"
  else
    require("astrocore").notify("not valid os", vim.log.levels.ERROR)
  end
  return os
end

-- get current buf relative path
function M.get_buf_parent_directory_relative_path()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_buf_name = vim.api.nvim_buf_get_name(current_buf)
  local relative_path = vim.fn.fnamemodify(current_buf_name, ":~:.")
  local parent_directory = vim.fn.fnamemodify(relative_path, ":h")
  return parent_directory
end

-- wsl clipboard provider config
function M.set_wsl_clipboard()
  local g = vim.g
  if M.get_os() == "linux-wsl" then
    local clipboard = {}
    local copy = {}
    copy["+"] = "clip.exe"
    copy["*"] = "clip.exe"
    local paste = {}
    paste["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
    paste["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
    clipboard["name"] = "'WslClipboard'"
    clipboard["copy"] = copy
    clipboard["paste"] = paste
    clipboard["cache_enabled"] = 0
    g.clipboard = clipboard
  end
end

-- osc52 clipboard provider config
function M.set_osc52_clipboard()
  local function copy(lines, _) require("osc52").copy(table.concat(lines, "\n")) end
  local function paste() return { vim.fn.split(vim.fn.getreg "", "\n"), vim.fn.getregtype "" } end
  vim.g.clipboard = {
    name = "osc52",
    copy = { ["+"] = copy, ["*"] = copy },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end

-- set_component_left set heirline component on the left side of the statusline
function M.set_component_left(opts, component)
  local index = 1
  for i, v in ipairs(opts.statusline) do
    if v.provider == "%=" then
      index = i
      break
    end
  end
  table.insert(opts.statusline, index, component)
end

local function get_ref_path()
  local path = vim.fn.expand("%:p")
  if path == "" then return nil end

  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
  if git_root ~= "" and vim.v.shell_error == 0 then
    if path:sub(1, #git_root) == git_root then
      path = path:sub(#git_root + 2)
    end
  else
    path = vim.fn.fnamemodify(path, ":.")
  end

  return path
end

function M.copy_reference()
  local path = get_ref_path()
  if not path then
    vim.notify("No file to copy", vim.log.levels.WARN)
    return
  end

  local mode = vim.api.nvim_get_mode().mode
  local reference

  if mode:match("^[vV\022]") then
    local l1 = vim.fn.line("v")
    local l2 = vim.fn.line(".")
    local start_line = math.min(l1, l2)
    local end_line = math.max(l1, l2)
    reference = start_line == end_line
      and (path .. ":" .. start_line)
      or (path .. ":" .. start_line .. "-" .. end_line)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  else
    reference = path .. ":" .. vim.fn.line(".")
  end

  vim.fn.setreg("+", reference)
  vim.notify("Copied: " .. reference)
end

return M
