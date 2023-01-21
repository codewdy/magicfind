local M = {}

local Object = require("lib.object").Object

M.BuffManager = Object:extend{
  _first_init = function(self)
    self.buffs = {}
  end,
  _clear = function(self)
    for k,v in pairs(self.buffs) do
      v:release()
      self[k] = nil
    end
  end,
  update = function(self, unit)
    for k,v in pairs(self.buffs) do
      if v:advance_timer() then
        v:update(unit)
      end
    end
  end,
  add_buff = function(self, buff_type, level, duration)
    if self.buffs[buff_type] == nil then
      self.buffs[buff_type] = buff_type()
    end
    self.buffs[buff_type]:merge(level, duration)
  end,
  clear_buff = function(self, buff_group)
    if buff_group == nil then
      for k,v in pairs(self.buffs) do
        v:clear()
      end
    else
      for k,v in pairs(self.buffs) do
        for _,tag in ipairs(self.tags) do
          if tag == buff_group then
            v:clear()
            break
          end
        end
      end
    end
  end,
}

return M
