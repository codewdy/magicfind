local M = {}

local Object = require("lib.object").Object
local DictUtils = require("lib.dict_utils")
local BuffManager = require("framework.buff_manager").BuffManager
local OwnedObjectList = require("lib.list").OwnedObjectList

M.Unit = Object:extend{
  _init = function(self, type, pos_x, pos_y)
    self.type = type
    self.pos_x = pos_x
    self.pos_y = pos_y
    self.size = type.size
    self.max_hp = type.max_hp
    self.hp = type.max_hp
    self.death = false
    self.buffs = BuffManager:new()
    self.skills = OwnedObjectList:new()
    self.skill_cooldown = {}
  end,
  _clear = function(self)
    self.buffs:release()
    self.skills:release()
  end,
  pre_update = function(self)
    self.status:reset()
    self.skills:clear()
    self.type.modifiers:update(self)
    self.type.talents:update(self)
    self.buffs:update(self)
    self.type.skills:update(self)

    self.max_hp = self.status:modifier("max_hp"):value()

    -- if max_hp is updated, update hp
    if self.status.max_hp ~= self.max_hp then
      self.hp = self.hp / self.max_hp * self.status.max_hp
      self.max_hp = self.status.max_hp
    end
  end,
  update = function(self)
    self.status:on_update(self)
  end,
  on_struck = function(self, unit)
    self.status:on_struct(self, unit)
  end,
  on_hit = function(self, unit)
    self.status:on_hit(self, unit)
  end,
  on_kill = function(self, unit)
    self.status:on_kill(self, unit)
  end,
  on_death = function(self, unit)
    self.status:on_death(self, unit)
  end,
}

return M
