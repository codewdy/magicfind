local M = {}

local Object = require("lib.object").Object

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

return M
