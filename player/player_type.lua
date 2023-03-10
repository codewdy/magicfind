local M = {}

local NoAI = require("ai.no_ai").NoAI
local UnitType = require("framework.unit_type").UnitType

M.PlayerType = UnitType{
  name = "Player",
  controller = NoAI,
  max_hp = 1,
  size = 2,
}

return M
