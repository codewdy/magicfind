local M = {}

local Object = require("lib.object").Object
local DictUtils = require("lib.dict_utils")
local MapCell = require("framework.map_cell").MapCell
local Map = require("framework.map").Map

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
    self.weight = args.weight or 1
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
  generate_map = function(self)
    local map = Map(self.block_w * self.map_w, self.block_h * self.map_h)
    local block_random_list = {}
    local block_pool = {}
    for _,block in self.block do
      if (block.min ~= nil) then
        for i=1,block.min do
          table.insert(block_pool, block)
        end
      end
      if (block.max ~= nil) then
        if (block.min ~= nil) then
          table.insert(block_random_list, {block, block.max - block.min})
        else
          table.insert(block_random_list, {block, block.max})
        end
      else
        table.insert(block_random_list, {block, self.map_w * self.map_h})
      end
    end
    for i=#block_pool+1,self.map_w*self.map_h do
      local total_rank = 0
      for _,b in block_random_list do
        if b[2] > 0 then
          total_rank = total_rank + b[1].weight
        end
      end
      local rank = math.random(total_rank)
      for _,b in ipairs(block_random_list) do
        if b[2] > 0 then
          if rank <= b[1].weight then
            table.insert(block_pool, b[1])
            b[2] = b[2] - 1
            break
          else
            rank = rank - b[1].weight
          end
        end
      end
    end
    for i=1,#block_pool-1 do
      local idx = math.random(i, #block_pool)
      local tmp = block_pool[i]
      block_pool[i] = block_pool[idx]
      block_pool[idx] = tmp
    end
    for i=0,self.w-1 do
      for j=0,self.h-1 do
        block_pool[i*self.h+j]:add_to_map(i * self.block_w, j * self.block_h, map)
      end
    end
    return map
  end,
  generate = function(self)
    local map = self:generate_map()
    local spawn = self.spawner:spawn(map)
    return {
      map = map,
      spawn = spawn
    }
  end,
}

return M
