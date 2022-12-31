local M = {}

local Object = require("lib.object").Object
local List = require("lib.list").List

M.Modifier = Object:extend{
  _first_init = function(self)
    self:clear()
  end,
  clear = function(self)
    self.base = 0
    self.increse = 1
    self.more = 1
  end,
  value = function(self)
    return self.base * self.increse * self.more
  end,
  add_base = function(self, m)
    self.base = self.base + m
  end,
  add_increase = function(self, m)
    self.increse = self.increse + m
  end,
  add_more = function(self, m)
    self.more = self.more * (1 + m)
  end,
}

M.Status = Object:extend{
  _first_init = function(self)
    self.update_handlers = List:new()
    self.struck_handlers = List:new()
    self.hit_handlers = List:new()
    self.kill_handlers = List:new()
    self.death_handlers = List:new()
    self.modifiers = {}
  end,
  _init = function(self)
    for k,v in pairs(self.modifiers) do
      v:release()
    end
    self.modifiers = {}
    self:reset()
  end,
  reset = function(self)
    self.update_handlers:clear()
    self.struck_handlers:clear()
    self.hit_handlers:clear()
    self.kill_handlers:clear()
    self.death_handlers:clear()
    for k,v in pairs(self.modifiers) do
      v:clear()
    end
  end,
  modifier = function(self, name)
    if self.modifiers[name] == nil then
      self.modifiers[name] = M.Modifier:new()
    end
    return self.modifiers[name]
  end,
  add_handler = function(self, handler)
    if handler.on_update ~= nil then
      self.update_handlers:push_back(handler)
    end
    if handler.on_struck ~= nil then
      self.struck_handlers:push_back(handler)
    end
    if handler.on_hit ~= nil then
      self.hit_handlers:push_back(handler)
    end
    if handler.on_kill ~= nil then
      self.kill_handlers:push_back(handler)
    end
    if handler.on_death ~= nil then
      self.death_handlers:push_back(handler)
    end
  end,
  on_update = function(self, unit)
    for i=1,self.update_handlers.size do
      self.update_handlers[i]:on_update(self, unit)
    end
  end,
  on_struck = function(self, src, dest)
    for i=1,self.struck_handlers.size do
      self.struck_handlers[i]:on_struck(self, src, dest)
    end
  end,
  on_hit = function(self, src, dest)
    for i=1,self.hit_handlers.size do
      self.hit_handlers[i]:on_hit(self, src, dest)
    end
  end,
  on_kill = function(self, src, dest)
    for i=1,self.kill_handlers.size do
      self.kill_handlers[i]:on_kill(self, src, dest)
    end
  end,
  on_death = function(self, src, dest)
    for i=1,self.death_handlers.size do
      self.death_handlers[i]:on_death(self, src, dest)
    end
  end,
}

return M
