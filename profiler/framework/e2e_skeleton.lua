local Skeleton = require("fake.skeleton").Skeleton
local Unit = require("framework.unit").Unit

ProfilerCase{
  name = "framework.e2e_skeleton",
  init = function(ctx)
    ctx.sketelon = {}
    for i=1,1000 do
      ctx.sketelon[i] = Unit(Skeleton)
    end
  end,
  run = function(ctx)
    for i=1,1000 do
      ctx.sketelon[i]:pre_update()
    end
    for i=1,1000 do
      ctx.sketelon[i]:update()
    end
  end,
}
