local M = {}

local Object = require("lib.object").Object
local List = require("lib.list").List
local Modifier = require("framework.modifier").Modifier

M.Status = Object:extend{
  _first_init = function(self)
    self.update_handlers = List()
    self.struck_handlers = List()
    self.hit_handlers = List()
    self.kill_handlers = List()
    self.death_handlers = List()
    self.modifiers = {}
  end,
  _init = function(self)
    for k,v in pairs(self.modifiers) do
      self.modifiers[k] = nil
      v:release()
    end
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
      self.modifiers[name] = Modifier()
    end
    return self.modifiers[name]
  end,
  on_update = function(self, unit)
    for i=1,self.update_handlers.size do
      self.update_handlers[i]:on_update(unit)
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
