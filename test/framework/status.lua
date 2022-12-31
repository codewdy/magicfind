local Status = require("framework.status").Status
local Modifier = require("framework.modifier").Modifier

TestCase("framework.status.modifier", function()
  local m = Modifier:new()
  m:add_base(3)
  m:add_base(2)
  m:add_increase(0.5)
  m:add_increase(0.2)
  m:add_more(-0.1)
  m:add_more(0.1)
  AssertEqual(m:value(), 5*1.7*0.9*1.1)
end)

TestCase("framework.status.status_modifier", function()
  local s = Status:new()
  s:modifier("X"):add_base(3)
  s:modifier("X"):add_base(2)
  s:modifier("X"):add_increase(0.5)
  s:modifier("X"):add_increase(0.2)
  s:modifier("X"):add_more(-0.1)
  s:modifier("X"):add_more(0.1)
  AssertEqual(s:modifier("X"):value(), 5*1.7*0.9*1.1)
  AssertEqual(s:modifier("Y"):value(), 0)
  s:release()
end)

TestCase("framework.status.on_update", function()
  local s = Status:new()
  local x = {}
  local handler = {
    on_update = function(self, src)
      src.a = 1
    end,
    on_kill = function(self, src, dst)
      src.b = 1
    end,
  }
  s.update_handlers:push_back(handler)
  s:on_update(x)
  AssertEqual(x, { a = 1 })
  s:on_kill(x, nil)
  AssertEqual(x, { a = 1, b = 2 })
  s:release()
end)
