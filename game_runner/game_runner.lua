local M = {}

local Object = require("lib.object").Object
local BattleRunner = require("framework.battle_runner").BattleRunner
local Player = require("player.player").Player
local DictUtils = require("lib.dict_utils")

M.GameRunner = Object:extend{
  _init = function(self, args)
    self.player = Player()
    self.args = DictUtils.merge({
      map = require("framework.map_template").MapCollection
    }, args)
  end,
  new_player = function(self, filename)
    self.filename = filename
    self.player:new()
  end,
  new_battle = function(self)
    local map = self.args.map:random():generate()
    self.battle_runner = BattleRunner(map.map)
    self.player.unit:set_loc(
        self.battle_runner, map.spawn.player.x, map.spawn.player.y)
    self.battle_runner:set_player(self.player.unit, false)
  end,
}

return M
