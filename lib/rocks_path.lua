local M = {}

local Utils = require("lib.utils")

function M.add_rock_path()
  package.cpath = Utils.script_path() .. "../" .. "rocks/lib/lua/5.1/?.so;" .. package.cpath
  package.cpath = Utils.script_path() .. "../" .. "rocks/lib/lua/5.1/?.dll;" .. package.cpath
  package.path = Utils.script_path() .. "../" .. "rocks/lib/lua/5.1/?.lua;" .. package.path
  package.path = Utils.script_path() .. "../" .. "rocks/lib/lua/5.1/?/init.lua;" .. package.path
end

return M
