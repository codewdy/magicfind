local StrUtils = require("lib.str_utils")

TestCase("lib.str_utils.starts_with", function()
  Assert(StrUtils.starts_with("ABC", ""))
  Assert(StrUtils.starts_with("ABC", "A"))
  Assert(StrUtils.starts_with("ABC", "ABC"))
  Assert(not StrUtils.starts_with("ABC", "C"))
end)
