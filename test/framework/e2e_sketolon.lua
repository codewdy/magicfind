local NoAI = require("ai.no_ai").NoAI
local Unit = require("framework.unit").Unit
local UnitType = require("framework.unit_type").UnitType
local Skill = require("framework.skill").Skill
local StackBuff = require("framework.buff").StackBuff
local CastType = require("framework.skill").CastType

local counter = 0

local AttackBuff = StackBuff:extend{
  update = function(self, unit)
    unit.status:modifier("max_hp"):add_increase(self.level)
  end,
}

local AttackSkill = Skill:extend{
  name = "FakeAttack",
  cast = function(self, args, src, dst)
    src.buffs:add_buff(AttackBuff, 0.1, 5)
  end
}

local sketelon_type = UnitType:new{
  controller = NoAI,
  skills = {
    AttackSkill:new(CastType.OnUpdate, {
      cast_factor = 1
    }),
  },
  max_hp = 2,
}

TestCase("framework.e2e_sketelon", function()
  local sketelon = Unit:new(sketelon_type, 0, 0)
  sketelon.hp = 1
  local rate = {1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.5, 1.5, 1.5}
  for i=1,#rate do
    sketelon:pre_update()
    sketelon:update()
    AssertEqual(sketelon.hp, rate[i])
  end
end)
