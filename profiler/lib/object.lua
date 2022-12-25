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

ProfilerCase{
  name = "lib.object.simple_new",
  init = function(ctx)
    Object._cache = {}
  end,
  run = function(ctx)
    ctx.o = Object:new()
  end,
}

ProfilerCase{
  name = "lib.object.naive_new",
  init = function(ctx)
    Object._cache = {}
  end,
  run = function(ctx)
    ctx.o = {}
  end,
}
