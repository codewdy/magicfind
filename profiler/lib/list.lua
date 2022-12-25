local List = require("lib.list").List

ProfilerCase{
  name = "lib.list.list_index",
  init = function(ctx)
    ctx.lst = List:new()
    for i=1,100 do
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
