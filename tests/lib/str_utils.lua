local str_utils = require("lib.str_utils")

TestCase("str_utils.starts_with", function()
  Assert(str_utils.starts_with("ABC", ""))
  Assert(str_utils.starts_with("ABC", "A"))
  Assert(str_utils.starts_with("ABC", "ABC"))
  Assert(not str_utils.starts_with("ABC", "C"))
end)
