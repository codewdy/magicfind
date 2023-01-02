local NoAI = require("ai.no_ai").NoAI
local Unit = require("framework.unit").Unit
local UnitType = require("framework.unit_type").UnitType
local Skill = require("framework.skill").Skill
local StackBuff = require("framework.buff").StackBuff
local CastType = require("framework.skill").CastType

local counter = 0

local AttackBuff = StackBuff:extend{
  update = function(self, unit)
    unit.status:modifier("attack_rate"):add_base(self.level)
  end,
}

local AttackSkill = Skill:extend{
  name = "FakeAttack",
  cast = function(self, args, src, dst)
    src.buffs:add_buff(AttackBuff, 1, 5)
  end
}

local sketelon_type = UnitType:new{
  controller = NoAI,
  skills = {
    AttackSkill:new(CastType.OnUpdate, {
      cast_factor = 1
    }),
  },
}

TestCase("framework.e2e_sketelon", function()
  local sketelon = Unit:new(sketelon_type, 0, 0)
  local rate = {0, 1, 2, 3, 4, 5, 5, 5, 5}
  for i=1,#rate do
    sketelon:pre_update()
    sketelon:update()
    AssertEqual(sketelon.status:modifier("attack_rate"):value(), rate[i])
  end
end)
