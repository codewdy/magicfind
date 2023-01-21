local M = {}

local Object = require("lib.object").Object
local DictUtils = require("lib.dict_utils")

M.MapCell = Object:extend{
  _init = function(self, args)
    args = DictUtils.merge({
      name = "",
      accessible = true,
    }, args)
  end
}

return M
