local Skeleton = require("fake.skeleton").Skeleton
local Unit = require("framework.unit").Unit

TestCase("framework.e2e_skeleton", function()
  local sketelon = Unit:new(nil, Skeleton, 0, 0)
  sketelon.hp = 1
  local rate = {1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.5, 1.5, 1.5}
  for i=1,#rate do
    sketelon:pre_update()
    sketelon:update()
    AssertEqual(sketelon.hp, rate[i])
  end
end)
