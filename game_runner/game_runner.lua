local M = {}

local Object = require("lib.object").Object
local BattleRunner = require("framework.battle_runner").BattleRunner
local Player = require("player.player").Player

M.GameRunner = Object:extend{
  _init = function(self)
    self.player = Player:new()
  end,
  new_player = function(self, filename)
    self.filename = filename
    self.player:new()
  end,
  new_battle = function(self)
    self.battle_runner = BattleRunner:new(nil)
    self.player.unit:set_loc(self.battle_runner, 0, 0)
    self.battle_runner:set_player(self.player.unit, false)
  end,
}

return M
