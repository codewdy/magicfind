local M = {}

local Object = require("lib.object").Object
local DictUtils = require("lib.dict_utils")

M.Unit = Object:extend{
  _first_init = function(self)
    self.pos_x = 0
    self.pos_y = 0
    self.size = 0
    self.max_hp = 0
    self.hp = 0
    self.death = false
  end,
  _init = function(self, type, pos_x, pos_y)
    self.type = type
    self.pos_x = pos_x
    self.pos_y = pos_y
    self.size = type.size
    self.max_hp = type.max_hp
    self.hp = type.max_hp
    self.death = false
  end,
  pre_update = function(self)
    self.status:reset()
    self.type.talents:update(self)
    self.buffs:update(self)
    self.type.skills:update(self)

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
  __static = {
    default_type = {
    },
    new_type = function(cls, type)
      return DictUtils.merge(cls.default_type, type)
    end,
  }
}

return M
