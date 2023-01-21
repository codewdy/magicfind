local M = {}

local Object = require("lib.object").Object
local List = require("lib.list").List

M.HitTest = Object:extend{
  _first_init = function(self)
    self.units = List()
    self.result = List()
  end,
  _init = function(self, units)
    for i=1,units.size do
      self.units:push_back(units[i])
    end
  end,
  _clear = function(self)
    self.units:clear()
    self.result:clear()
  end,
  hit_circle = function(self, x, y, max_r, min_r)
    min_r = min_r or 0
    self.result:clear()
    for i=1,self.units.size do
      local unit = self.units[i]
      local r2 = ((x - unit.pos_x) * (x - unit.pos_x) +
          (y - unit.pos_y) * (y - unit.pos_y))
      if ((max_r + unit.size) * (max_r + unit.size) >= r2 and
          ((min_r <= unit.size) or
          (min_r - unit.size) * (min_r - unit.size) <= r2)) then
        self.result:push_back(unit)
      end
    end
    return self.result
  end
}

return M
