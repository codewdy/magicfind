local M = {}

local Object = require("lib.object").Object
local List = require("lib.list").List

M.Map = Object:extend{
  _init = function(self, w, h)
    self.list = List()
    self.w = w
    self.h = h
  end,
  _clear = function(self)
    self.list:release()
  end,
  add = function(self, x, y, cell)
    self.list:push_back({ x = x, y = y, cell = cell })
  end,
}

return M
