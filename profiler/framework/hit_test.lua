local HitTest = require("framework.hit_test").HitTest
local List = require("lib.list").List

ProfilerCase{
  name = "framework.hit_test.hit_circle",
  init = function(ctx)
    math.randomseed(0)
    local units = List()
    for i=1,100 do
      local px = (math.random() - 0.5) * i
      local py = (math.random() - 0.5) * i
      for j=1,10 do
        units:push_back({
          pos_x = px + math.random(),
          pos_y = py + math.random(),
          size = 1
        })
      end
    end
    ctx.tester = HitTest(units)
  end,
  run = function(ctx)
    ctx.tester:hit_circle(0, 0, 1)
  end,
}
