local M = {}

local List = require("lib.list").List

function M.equal_msg(a, b)
  if type(a) ~= type(b) then
    return " : type error. " .. type(a) .. " vs " .. type(b) .. "."
  end
  if type(a) == "nil" or
      type(a) == "number" or
      type(a) == "string" or
      type(a) == "boolean" or
      type(a) == "function" then
    if a ~= b then
      return " : value error. " .. tostring(a) .. " vs " .. tostring(b) .. ". "
    else
      return nil
    end
  end
  if type(a) == "table" then
    if List:is_list(a) or List:is_list(b) then
      if #a ~= #b then
        return " : length error. " .. tostring(#a) .. " vs " .. tostring(#b)
      end
      for i = 1,#a do
        local rst = M.equal_msg(a[i], b[i])
        if rst ~= nil then
          return tostring(i) .. "." .. rst
        end
      end
      return nil
    end
    if type(a.equal) == "function" then
      if a:equal(b) then
        return nil
      else
        return " : object error. "
      end
    end
    for k, v in pairs(a) do
      local rst = M.equal_msg(v, b[k])
      if rst ~= nil then
        return k .. "." .. rst
      end
    end
    return nil
  end
end

function M.assert(b)
  if not b then
    error("assert error.\n" .. debug.traceback())
  end
end

function M.assert_equal(a, b)
  local msg = M.equal_msg(a, b)
  if msg ~= nil then
    error(msg .. "\n" .. debug.traceback())
  end
end

return M
