local M = {}

local Object = require("lib.object").Object

-- new buff will rewrite old buff
M.LevelBuff = Object:extend{
  _init = function(self)
    self.level = 0
    self.next_level = 0
    self.duration = 0
  end,
  advance_timer = function(self)
    if self.duration > 0 then
      self.duration = self.duration - 1
      return true
    else
      self.level = 0
      return false
    end
  end,
  merge = function(self, level, duration)
    self.level = math.max(self.level, level)
    self.duration = math.max(self.duration, duration)
  end,
}

-- new buff will stack with old buff
M.StackBuff = Object:extend{
  _first_init = function(self)
    self.timeline = {}
  end,
  _init = function(self)
    self.level = 0
    self.timer = 0
    for k,v in pairs(self.timeline) do
      self.timeline[k] = nil
    end
  end,
  advance_timer = function(self)
    self.timer = self.timer + 1
    if self.timeline[self.timer] ~= nil then
      self.level = self.level - self.timeline[self.timer]
      self.timeline[self.timer] = nil
    end
    return next(self.timeline) ~= nil
  end,
  merge = function(self, level, duration)
    duration = math.floor(duration)
    if duration <= 0 then
      return
    end
    self.level = self.level + level
    if self.timeline[self.timer + duration + 1] == nil then
      self.timeline[self.timer + duration + 1] = level
    else
      self.timeline[self.timer + duration + 1] = self.timeline[self.timer + duration + 1] + level
    end
  end,
}

return M
