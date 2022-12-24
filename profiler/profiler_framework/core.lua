local M = {}

local dict_utils = require("lib.dict_utils")
local str_utils = require("lib.str_utils")

M.cases = {}

function M.profiler_case(args)
  M.cases[args.name] = dict_utils.merge({
    init = function(ctx) end,
    time = 1
  }, args)
end

function M.profiler_main()
  local cases = {}
  if #arg == 0 then
    for k, v in pairs(M.cases) do
      table.insert(cases, k)
    end
  else
    for k, v in pairs(M.cases) do
      local found = false
      for i = 1,#arg do
        if str_utils.starts_with(k, arg[i]) then
          found = true
        end
      end
      if found then
        table.insert(cases, k)
      end
    end
  end
  table.sort(cases)
  for _,case in ipairs(cases) do
    local args = M.cases[case]
    local ctx = {}
    local cycle = 0
    args.init(ctx)
    local start_time = os.clock()
    local cycle_checkpoint = 1
    while true do
      args.run(ctx)
      cycle = cycle + 1
      if cycle >= cycle_checkpoint then
        cycle_checkpoint = cycle_checkpoint * 1.3 + 1
        if os.clock() - start_time > args.time then
          break
        end
      end
    end
    print("profiler[" .. case .. "]: " .. (os.clock() - start_time) / cycle)
  end
end

return M
