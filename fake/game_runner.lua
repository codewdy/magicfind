local M = {}

local GameRunner = require("game_runner.game_runner").GameRunner
local FakeMap = require("fake.map").Collection

M.create = function()
  return GameRunner{
    map = FakeMap
  }
end

return M
