local M = {}

local Spawner = require("framework.spawner")
local MapTemplate = require("framework.map_template").MapTemplate
local MapCollection = require("framework.map_template").MapCollection

M.Collection = MapCollection()

local S = require("map_cell.simple").Stone
local G = require("map_cell.simple").Grass
local SG = {S, G}

MapTemplate{
  name = "Simple",
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
}:register(M.Collection)

return M
