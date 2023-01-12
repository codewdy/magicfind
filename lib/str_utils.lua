local M = {}

function M.starts_with(str, start)
  return str:sub(1, #start) == start
end

function M.ends_with(str, e)
  if e == "" then
    return true
  end
  return str:sub(-#e) == e
end

return M
