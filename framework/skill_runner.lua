local M = {}

local Object = require("lib.object").Object
local SkillContext = require("framework.skill_context").SkillContext
local Modifier = require("framework.modifier").Modifier

M.CastType = {
  OnUpdate = 1,
  OnHit = 2,
  OnStruck = 3,
  OnKill = 4,
  OnDeath = 5
}

-- store in UnitType.skills. skill + how to cast it.
M.SkillRunner = Object:extend{
  _init = function(self, cast_type, skill, args)
    self.cast_type = cast_type
    self.skill = skill
    self.args = args
  end,
  update = function(self, idx, unit)
    local args = {}
    for k,v in pairs(self.skill.args) do
      local base = v
      if self.args[k] ~= nil then
        base = self.args[k]
      end
      local mod = Modifier:new()
      mod:merge(unit.status:modifier("skill_arg.name." .. self.skill.name .. "." .. k))
      mod:merge(unit.status:modifier("skill_arg.global." .. k))
      for _,tag in ipairs(self.skill.tag) do
        mod:merge(unit.status:modifier("skill_arg.tag." .. tag .. "." .. k))
      end
      mod:add_base(base)
      args[k] = mod:value()
    end
    local skill_context = SkillContext:new(idx, self.skill, args)
    if self.cast_type == M.CastType.OnUpdate then
      unit.status.update_handlers:push_back(skill_context)
    elseif self.cast_type == M.CastType.OnHit then
      unit.status.hit_handlers:push_back(skill_context)
    elseif self.cast_type == M.CastType.OnStruck then
      unit.status.struck_handlers:push_back(skill_context)
    elseif self.cast_type == M.CastType.OnKill then
      unit.status.kill_handlers:push_back(skill_context)
    elseif self.cast_type == M.CastType.OnDeath then
      unit.status.death_handlers:push_back(skill_context)
    end
  end,
}

return M
