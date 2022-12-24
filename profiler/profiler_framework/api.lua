local M = {}

local core = require("profiler.profiler_framework.core")

M.profiler_case = core.profiler_case
ProfilerCase = M.profiler_case

M.profiler_main = core.profiler_main
ProfilerMain = M.profiler_main

return M
