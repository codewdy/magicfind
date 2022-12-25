local Object = require("lib.object").Object

ProfilerCase{
  name = "lib.object.new_and_release",
  init = function(ctx)
    Object._cache = {}
  end,
  run = function(ctx)
    ctx.o = Object:new()
    ctx.o:release()
  end,
}
