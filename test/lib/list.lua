local List = require("lib.list").List

TestCase("lib.list.simple", function()
  local lst = List()
  lst:push_back(1)
  lst:push_back(2)
  lst:push_back(3)
  Assert(lst.size == 3)
  Assert(lst[1] == 1)
  Assert(lst[2] == 2)
  Assert(lst[3] == 3)
end)
