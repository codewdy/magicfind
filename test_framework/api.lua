local M = {}

local assert = require("test_framework.assert")
local core = require("test_framework.core")

M.test_case = core.test_case
TestCase = M.test_case

M.test_main = core.test_main
TestMain = M.test_main

M.assert = assert.assert
Assert = M.assert

M.assert_equal = assert.assert_equal
AssertEqual = M.assert_equal

return M
