local M = {}

local Object = require("lib.object").Object
local DictUtils = require("lib.dict_utils")
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
M.Skill = Object:extend{
  name = "UNKNOWN",
  default_args = {},
  default_tags = {},
  _init = function(self, cast_type, args)
    self.cast_type = cast_type
    self.args = DictUtils.merge(self.default_args, args)
    self.tags = self.default_tags
  end,
  update = function(self, idx, unit)
    local args = {}
    for k,v in pairs(self.args) do
      local mod = Modifier()
      mod:merge(unit.status:modifier("skill_arg.name." .. self.name .. "." .. k))
      mod:merge(unit.status:modifier("skill_arg.global." .. k))
      for _,tag in ipairs(self.tags) do
        mod:merge(unit.status:modifier("skill_arg.tag." .. tag .. "." .. k))
      end
      mod:add_base(v)
      args[k] = mod:value()
    end
    local skill_context = SkillContext(idx, self, args)
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
  cast = function(self, args, src, dst)
    error("try cast a abstract skill")
  end
}

return M
