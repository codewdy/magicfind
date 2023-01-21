local M = {}

local NoAI = require("ai.no_ai").NoAI
local Unit = require("framework.unit").Unit
local UnitType = require("framework.unit_type").UnitType
local Skill = require("framework.skill").Skill
local StackBuff = require("framework.buff").StackBuff
local CastType = require("framework.skill").CastType

M.SkeletonBuff = StackBuff:extend{
  update = function(self, unit)
    unit.status:modifier("max_hp"):add_increase(self.level)
  end,
}

M.SkeletonSkill = Skill:extend{
  name = "SkeletonSkill",
  cast = function(self, args, src, dst)
    src.buffs:add_buff(M.SkeletonBuff, 0.1, 5)
  end
}

M.Skeleton = UnitType{
  name = "Skeleton",
  controller = NoAI,
  skills = {
    M.SkeletonSkill(CastType.OnUpdate, {
      cast_factor = 1
    }),
  },
  max_hp = 2,
}

return M
