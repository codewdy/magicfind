local M = {}

local Object = require("lib.object").Object
local DictUtils = require("lib.dict_utils")
local MapCell = require("framework.map_cell").MapCell

M.details = {}

M.details.MapCellGenerator = Object:extend{
  _init = function(self, arg)
    if arg._class == MapCell then
      self.list = { arg }
    else
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
    end
  end,
  gen = function(self)
    return self.list[math.random(#self.list)]
  end,
  __static = {
    cache = {},
    xnew = function(cls, arg)
      if cls.cache[arg] == nil then
        cls.cache[arg] = cls(arg)
      end
      return cls.cache[arg]
    end,
  },
}

M.details.MapBlockSpec = Object:extend{
  _init = function(self, w, h, args)
    self.w = w
    self.h = h
    self.min = args.min
    self.max = args.max
    self.weight = args.weight
    self.list = {}
    for i=1,w*h do
      self.list[i] = M.details.MapCellGenerator:xnew(args[i])
    end
  end,
  add_to_map = function(self, map, x, y)
    for i=0,self.w-1 do
      for j=0,self.h-1 do
        local idx = i*self.h+j+1
        map.add(x + i, y + j, self.list[idx]:gen())
      end
    end
  end
}

M.MapTemplate = Object:extend{
  _init = function(self, args)
    self.block_w = args.block_w
    self.block_h = args.block_h
    self.map_w = args.map_w
    self.map_h = args.map_h
    self.spawner = args.spawner
    self.block = {}
    for idx,b in ipairs(args.block) do
      self.block[idx] = M.details.MapBlockSpec(self.block_w, self.block_h, b)
    end
  end,
  generate = function(self)
  end,
}

return M
