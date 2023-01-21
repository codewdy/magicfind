local M = {}

local Object = require("lib.object").Object
local PlayerType = require("player.player_type").PlayerType
local Unit = require("framework.unit").Unit

M.Player = Object:extend{
  new = function(self)
    self.unit = Unit(PlayerType)
  end,
  load = function(self, filename)
    self.unit = Unit(PlayerType)
    -- TODO
  end,
  save = function(self, filename)
    -- TODO
  end,
}

return M
