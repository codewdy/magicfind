local Object = require("lib.object").Object

TestCase("lib.object.new_and_delete", function()
  Object._cache = {}
  local a = Object:new()
  local b = Object:new()
  a:release()
  local c = Object:new()
  Assert(a == c)
  Assert(a ~= b)
end)

TestCase("lib.object.extend", function()
  Object._cache = {}
  local x = Object:new()
  local cls = Object:extend{ a = 1, __static = { b = 2 }}
  local a = cls:new()
  local b = cls:new()
  a:release()
  local c = cls:new()
  Assert(a == c)
  Assert(a ~= b)
  Assert(a ~= x)
  Assert(b ~= x)
  Assert(a.a == 1)
  Assert(b.a == 1)
  Assert(cls.b == 2)
end)

TestCase("lib.object.extend_and_extend", function()
  Object._cache = {}
  local x = Object:new()
  local cls = Object:extend{ a = 1, __static = { b = 2 }}
  cls = cls:extend{ a = 2, __static = { c = 3 }}
  local a = cls:new()
  local b = cls:new()
  a:release()
  local c = cls:new()
  Assert(a == c)
  Assert(a ~= b)
  Assert(a ~= x)
  Assert(b ~= x)
  Assert(a.a == 2)
  Assert(b.a == 2)
  Assert(cls.b == 2)
  Assert(cls.c == 3)
end)

TestCase("lib.object.default_field", function()
  local cls = Object:extend{
    x = 0
  }
  local a = cls:new()
  local b = cls:new()
  b.x = b.x + 1
  Assert(a.x == 0)
  Assert(b.x == 1)
end)

TestCase("lib.object.first_init", function()
  local x = 0
  local cls = Object:extend{
    _first_init=function(self) self.x = x end
  }
  local a = cls:new()
  x = 1
  local b = cls:new()
  Assert(a.x == 0)
  Assert(b.x == 1)
end)
