local M = {}

local MapCell = require("framework.map_cell").MapCell

M.Grass = MapCell{
  name = "Grass",
  accessible = true,
}

M.Stone = MapCell{
  name = "Stone",
  accessible = false,
}

return M

