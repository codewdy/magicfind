local M = {}

local lfs = require("lfs")

local function get_all_files_helper(dir, prefix, lst)
  for entry in lfs.dir(dir .. prefix) do
    if entry ~= "." and entry ~= ".." then
      local attr = lfs.attributes(dir .. prefix .. entry)
      if attr.mode == "directory" then
        get_all_files_helper(dir, prefix .. entry .. "/", lst)
      else
        table.insert(lst, prefix .. entry)
      end
    end
  end
end

function M.get_all_files(dir)
  local rst = {}
  get_all_files_helper(dir, "", rst)
  return rst
end

return M
