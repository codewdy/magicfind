local M = {}

local Object = require("lib.object").Object

-- stored in unit.skills, and used by status handler.
-- should be create/release per frame.
M.SkillContext = Object:extend{
  _init = function(self, idx, skill, args)
    self.idx = idx
    self.skill = skill
    self.args = args
  end,
  on_update = function(self, unit)
    if unit.skill_cooldown[self.idx] == nil then
      unit.skill_cooldown[self.idx] = 0
    end
    unit.skill_cooldown[self.idx] = unit.skill_cooldown[self.idx] + 1
    while unit.skill_cooldown[self.idx] >= 1 / self.args.cast_factor do
      unit.skill_cooldown[self.idx] = unit.skill_cooldown[self.idx] - 1 / self.args.cast_factor
      self.skill:cast(self.args, unit, unit.target)
    end
  end,
  on_struck = function(self, src, dst)
    if math.random() < self.args.cast_factor then
      self.skill:cast(self.args, src, dst)
    end
  end,
  on_hit = function(self, src, dst)
    if math.random() < self.args.cast_factor then
      self.skill:cast(self.args, src, dst)
    end
  end,
  on_kill = function(self, src, dst)
    if math.random() < self.args.cast_factor then
      self.skill:cast(self.args, src, dst)
    end
  end,
  on_death = function(self, src, dst)
    if math.random() < self.args.cast_factor then
      self.skill:cast(self.args, src, dst)
    end
  end,
}

return M
