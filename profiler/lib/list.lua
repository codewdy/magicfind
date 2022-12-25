local List = require("lib.list").List

K = 100

ProfilerCase{
  name = "lib.list.simple_list_iter_index",
  init = function(ctx)
    ctx.lst = {}
    for i=1,K do
      ctx.lst[i] = 1
    end
  end,
  run = function(ctx)
    local s = 0
    for i=1,#ctx.lst do
      s = s + ctx.lst[i]
    end
  end
}

ProfilerCase{
  name = "lib.list.simple_list_iter_ipairs",
  init = function(ctx)
    ctx.lst = {}
    for i=1,K do
      ctx.lst[i] = 1
    end
  end,
  run = function(ctx)
    local s = 0
    for _,x in ipairs(ctx.lst) do
      s = s + x
    end
  end
}

ProfilerCase{
  name = "lib.list.list_index",
  init = function(ctx)
    ctx.lst = List:new()
    for i=1,K do
      ctx.lst:push_back(1)
    end
  end,
  run = function(ctx)
    local s = 0
    for i=1,ctx.lst.size do
      s = s + ctx.lst[i]
    end
  end
}

ProfilerCase{
  name = "lib.list.list_index_ipairs",
  init = function(ctx)
    ctx.lst = List:new()
    for i=1,K do
      ctx.lst:push_back(1)
    end
  end,
  run = function(ctx)
    local s = 0
    for _,x in ipairs(ctx.lst) do
      s = s + x
    end
  end
}
