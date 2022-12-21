local dict_utils = require("lib.dict_utils")

TestCase("lib.dict_utils.merge", function()
  AssertEqual(
  { a = 1, b = 2 },
  dict_utils.merge({ a = 2, b = 2 }, { a = 1 }))
end)
