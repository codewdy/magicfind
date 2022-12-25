local hit_test = require("framework.hit_test")
local list = require("lib.list")

ProfilerCase{
  name = "framework.hit_test.hit_circle",
  init = function(ctx)
    math.randomseed(0)
    local units = list.List:new()
    for i=1,1000 do
      units:push_back(
          { pos_x = 1 + math.random(), pos_y = 1 + math.random(), size = 1 })
    end
    ctx.tester = hit_test.HitTest:new(units)
  end,
  run = function(ctx)
    ctx.tester:hit_circle(1, 1, 1)
  end,
}
