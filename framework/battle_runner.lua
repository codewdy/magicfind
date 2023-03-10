local M = {}

local Object = require("lib.object").Object
local Config = require("framework.config")
local OwnedObjectList = require("lib.list").OwnedObjectList
local List = require("lib.list").List

M.BattleRunner = Object:extend{
  _init = function(self, map)
    self.frame = 0
    self.idx = 0
    self.map = map
    self.owned_units = OwnedObjectList()
    self.units = List()
    self.effects = OwnedObjectList()
    self.player = nil
  end,
  _clear = function(self)
    self.map:release()
    self.owned_units:release()
    self.units:release()
    self.effects:release()
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
  set_player = function(self, unit)
    self.player = unit
    unit.idx = self.idx
    self.idx = self.idx + 1
    self.units:push_back(unit)
  end,
  add_unit = function(self, unit)
    unit.idx = self.idx
    self.idx = self.idx + 1
    self.units:push_back(unit)
    self.owned_units:push_back(unit)
  end,
  add_effect = function(self, effect)
    effect.idx = self.idx
    self.effect = self.effect + 1
    self.effect:push_back(effect)
  end,
}

return M
