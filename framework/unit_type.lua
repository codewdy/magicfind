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
      v:update(k, unit)
    end
  end,
}

M.UnitType = Object:extend{
  _init = function(self, args)
    args = DictUtils.merge({
      name = "",
      modifiers = {},
      talents = {},
      skills = {},
      size = 1,
      max_hp = 1,
    }, args)
    self.name = args.name
    self.modifiers = M.details.Modifiers(args.modifiers)
    self.talents = M.details.Talents(args.talents)
    self.skills = M.details.Skills(args.skills)
    self.controller = args.controller
    self.size = args.size
    self.max_hp = args.max_hp
  end,
}

return M
