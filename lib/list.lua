local M = {}

local object = require("lib.object")

M.List = object.Object:extend{
  fields = {
    _first_init = function(self)
      self.size = 0
    end,
    _clear = function(self)
      self:clear()
    end,
    _erase_unit = function(self, unit)
    end,
    clear = function(self)
      self:clear()
    end,
    resize = function(self, size)
      if self.size < size then
        for i = self.size+1,size do
          self[i] = nil
        end
        self.size = size
      elseif self.size > size then
        for i = size+1,self.size do
          self:_erase_unit(self[i])
          self[i] = nil
        end
        self.size = size
      end
    end,
    create_back = function(self)
      self:resize(self.size + 1)
    end,
    push_back = function(self, unit)
      self.size = self.size + 1
      self[self.size] = unit
    end,
    pop_back = function(self)
      if self.size > 0 then
        self:resize(self.size - 1)
      end
    end,
    back = function(self)
      return self[self.size]
    end,
  }
}

M.OwnedObjectList = M.List:extend{
  fields = {
    _erase_unit = function(self, unit)
      if unit ~= nil then
        unit:release()
      end
    end
  }
}

return M
