local M = {}

local Spawner = require("framework.spawner")
local MapTemplate = require("framework.map_template").MapTemplate

local S = require("map_cell.simple").Stone
local G = require("map_cell.simple").Grass
local SG = {S, G}

M.Simple = MapTemplate{
  block_w = 4,
  block_h = 4,
  map_w = 5,
  map_h = 5,
  block = {
    {
      G, G, G, G,
      G, S, S, G,
      G, S, S, G,
      G, G, G, G,
    },
    {
      G, G, G, G,
      G, G, G, G,
      G, G, G, G,
      G, G, G, G,
    },
    {
      G, G, G, G,
      G,SG,SG, G,
      G,SG,SG, G,
      G, G, G, G,
    }
  },
  spawner = Spawner.Empty()
}

return M
