local M = {}

local Object = require("lib.object").Object
local Context = require("framework.context").Context
local Config = require("framework.config")

M.BattleRunner = Object:extend{
  _init = function(self, map, units)
    self.map = map
    self.units = units
    self.frame = 0
  end,
  move = function(self)
    for _,unit in ipairs(self.units) do
      unit:move()
    end
  end,
  update = function(self)
    for _,unit in ipairs(self.units) do
      unit:pre_update()
    end
    for _,unit in ipairs(self.units) do
      unit:update()
    end
  end,
  run = function(self)
    self:move()
    if self.frame % Config.BattleRunner.FramePerUpdate == 0 then
      self:update()
    end
    self.frame = self.frame + 1
  end,
}

return M
