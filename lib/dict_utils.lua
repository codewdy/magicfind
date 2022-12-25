local M = {}

function M.merge(...)
  local rst = {}
  for _,dict in ipairs({...}) do
    if dict ~= nil then
      for k,v in pairs(dict) do
        rst[k] = v
      end
    end
  end
  return rst
end

function M.clone(dict)
  local rst = {}
  for k,v in pairs(dict) do
    rst[k] = v
  end
  return rst
end

return M
