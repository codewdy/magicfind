local M = {}

local Object = require("lib.object").Object

M.NoAI = Object:extend{
  _init = function(self, unit)
  end,
  find_target = function(self)
    return nil
  end,
  move = function(self)
  end,
}

return M
