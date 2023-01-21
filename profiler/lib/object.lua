local Object = require("lib.object").Object

ProfilerCase{
  name = "lib.object.new_and_release",
  init = function(ctx)
    Object._cache = {}
  end,
  run = function(ctx)
    ctx.o = Object()
    ctx.o:release()
  end,
}

ProfilerCase{
  name = "lib.object.new_and_release_with_call",
  init = function(ctx)
    Object._cache = {}
  end,
  run = function(ctx)
    ctx.o = Object()
    ctx.o:release()
  end,
}
