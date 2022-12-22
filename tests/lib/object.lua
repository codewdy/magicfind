local object = require("lib.object")

TestCase("object.new_and_delete", function()
  object.Object._cache = {}
  local a = object.Object:new()
  local b = object.Object:new()
  a:release()
  local c = object.Object:new()
  Assert(a == c)
  Assert(a ~= b)
end)

TestCase("object.extend", function()
  object.Object._cache = {}
  local x = object.Object:new()
  local cls = object.Object:extend({fields = { a = 1 }, static = { b = 2 }})
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

TestCase("object.extend_and_extend", function()
  object.Object._cache = {}
  local x = object.Object:new()
  local cls = object.Object:extend({fields = { a = 1 }, static = { b = 2 }})
  cls = cls:extend({fields = { a = 2 }, static = { c = 3 }})
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

TestCase("object.first_init", function()
  local x = 0
  local cls = object.Object:extend({
    fields = {_first_init=function(self) self.x = x end}
  })
  local a = cls:new()
  x = 1
  local b = cls:new()
  Assert(a.x == 0)
  Assert(b.x == 1)
end)
