local M = {}

local str_utils = require("lib.str_utils")

M.cases = {}

function M.test_case(name, f)
  M.cases[name] = f
end

function M.test_main()
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
  local failed = {}
  for _,case in ipairs(cases) do
    local status, err = pcall(M.cases[case])
    if status then
      print("\27[32m" .. case .. " : PASS" .. "\27[0m")
    else
      print("\27[31m" .. case .. " : " .. err .. "\27[0m")
      table.insert(failed, case)
    end
  end
  if #failed == 0 then
    print("All test pass! PASS:" .. #cases .. "/" .. #cases)
  else
    print("Some test failed! PASS:" .. (#cases - #failed) .. "/" .. #cases)
    print("Failed Case: " .. table.concat(failed, ", "))
  end
end

return M
