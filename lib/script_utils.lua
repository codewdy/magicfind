local M = {}

function M.script_path(stack)
  stack = stack or 0
  local str = debug.getinfo(2 + stack, "S").source:sub(2)
  return str:match("(.*/)") or "./"
end

return M

