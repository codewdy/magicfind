local M = {}

local Object = require("lib.object").Object
local DictUtils = require("lib.dict_utils")

M.details = {}

M.details.Modifiers = Object:extend{
  _init = function(self, modifiers)
    self.modifiers = modifiers
  end,
  update = function(self, unit)
    for k,v in pairs(self.modifiers) do
      unit.status:modifier(k):add_base(v)
    end
  end,
}

M.details.Talents = Object:extend{
  _init = function(self, talents)
    self.talents = talents
  end,
  update = function(self, unit)
    for k,v in ipairs(self.talents) do
      v:update(unit)
    end
  end,
}

M.details.Skills = Object:extend{
  _init = function(self, skills)
    self.skills = skills
  end,
  update = function(self, unit)
    for k,v in ipairs(self.skills) do
      v:update(unit)
    end
  end,
}

M.UnitType = Object:extend{
  _init = function(self, args)
    args = DictUtils.merge({
      modifiers = {},
      talents = {},
      skills = {}
    }, args)
    self.modifiers = M.details.Modifiers:new(args.modifiers)
    self.talents = M.details.Talents:new(args.talents)
    self.skills = M.details.Skills:new(args.skills)
  end,
}

return M
