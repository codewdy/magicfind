local object = require("lib.object")

ProfilerCase{
  name = "lib.object.new_and_release",
  init = function(ctx)
    object.Object._cache = {}
  end,
  run = function(ctx)
    ctx.o = object.Object:new()
    ctx.o:release()
  end,
}

ProfilerCase{
  name = "lib.object.simple_new",
  init = function(ctx)
    object.Object._cache = {}
  end,
  run = function(ctx)
    ctx.o = object.Object:new()
  end,
}

ProfilerCase{
  name = "lib.object.naive_new",
  init = function(ctx)
    object.Object._cache = {}
  end,
  run = function(ctx)
    ctx.o = {}
  end,
}
