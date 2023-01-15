local M = {}

local ScriptUtils = require("lib.script_utils")

M.load = function(root)
  if root == nil then
    root = ScriptUtils.script_path()
  end
  ScriptUtils.set_root_path(root)
  require("lib.rocks_path").add_rock_path()
end

return M
