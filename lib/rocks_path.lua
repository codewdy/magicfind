local M = {}

local ScriptUtils = require("lib.script_utils")

function M.add_rock_path()
  package.cpath = ScriptUtils.root_path .. "rocks/lib/lua/5.1/?.so;" .. package.cpath
  package.cpath = ScriptUtils.root_path .. "rocks/lib/lua/5.1/?.dll;" .. package.cpath
  package.path = ScriptUtils.root_path .. "rocks/lib/lua/5.1/?.lua;" .. package.path
  package.path = ScriptUtils.root_path .. "rocks/lib/lua/5.1/?/init.lua;" .. package.path
end

return M
