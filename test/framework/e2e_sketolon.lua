local Sketelon = require("fake.sketelon").Sketelon
local Unit = require("framework.unit").Unit

TestCase("framework.e2e_sketelon", function()
  local sketelon = Unit:new(Sketelon, 0, 0)
  sketelon.hp = 1
  local rate = {1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.5, 1.5, 1.5}
  for i=1,#rate do
    sketelon:pre_update()
    sketelon:update()
    AssertEqual(sketelon.hp, rate[i])
  end
end)
