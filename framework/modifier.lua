local M = {}

local Object = require("lib.object").Object

M.Modifier = Object:extend{
  _first_init = function(self)
    self:clear()
  end,
  clear = function(self)
    self.base = 0
    self.increse = 0
    self.more = 1
  end,
  value = function(self)
    return self.base * (1 + self.increse) * self.more
  end,
  add_base = function(self, m)
    self.base = self.base + m
  end,
  add_increase = function(self, m)
    self.increse = self.increse + m
  end,
  add_more = function(self, m)
    self.more = self.more * (1 + m)
  end,
  merge = function(self, rhs)
    self.base = self.base + rhs.base
    self.increse = self.increse + rhs.increse
    self.more = self.more * rhs.more
  end
}

return M
