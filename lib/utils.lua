local M = {}

function M.script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)") or "./"
end

return M
