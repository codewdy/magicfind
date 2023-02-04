local M = {}

local Object = require("lib.object").Object
local UnitType = require("framework.unit_type").UnitType

M.Base = Object:extend{
  _spawn_player = function(self, map, ctx)
    -- TODO: get player location
    ctx.player = {
      x = map.w / 2,
      y = map.h / 2,
    }
  end,
  _random_monster_location = function(self, map, ctx, monster)
    -- TODO
    for _,m in ipairs(monster) do
      table.insert(ctx.monster, {
        type = m,
        x = map.w * math.random(),
        y = map.h * math.random(),
      })
    end
  end,
  spawn = function(self, map)
    local ctx = {}
    self:_spawn_player(map, ctx)
    ctx.monster = {}
    local unhandled_monster = self:_spawn_monster(map, ctx)
    self:_random_monster_location(map, ctx, unhandled_monster)
    return ctx
  end,
}

M.Empty = M.Base:extend{
  _spawn_monster = function(self, map, ctx)
    return {}
  end,
}

M.Simple = M.Base:extend{
  _init = function(self, m)
    self.m = m
  end,
  _spawn_monster = function(self, map, ctx)
    return { self.m }
  end,
}

M.Identity = function(m)
  if m._class == M.Base then
    return m
  else
    return M.Simple(m)
  end
end

M.Random = M.Base:extend{
  _init = function(self, args)
    self.list = {}
    for k,v in pairs(arg) do
      self.list = {}
      if type(k) == "number" then
        table.insert(self.list, v)
      else
        for i=1,v do
          table.insert(self.list, k)
        end
      end
    end
  end,
  _spawn_monster = function(self, map, ctx)
    return { self.list[math.random(#self.list)] }
  end
}

M.Repeat = M.Base:extend{
  _init = function(self, m, min, max)
    self.m = M.Identity(m)
    self.min = min
    self.max = max
  end,
  _spawn_monster = function(self, map, ctx)
    local num = math.random(self.min, self.max)
    local ret = {}
    for i=1,num do
      for _,n in ipairs(self.m:_spawn_monster()) do
        table.insert(ret, n)
      end
    end
  end
}

M.Group = M.Base:extend{
  -- TODO
}

return M
