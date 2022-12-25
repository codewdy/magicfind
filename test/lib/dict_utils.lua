local DictUtils = require("lib.dict_utils")

TestCase("lib.dict_utils.merge", function()
  AssertEqual(
  { a = 1, b = 2 },
  DictUtils.merge({ a = 2, b = 2 }, { a = 1 }))
end)
