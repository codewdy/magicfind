local M = {}

local DictUtils = require("lib.dict_utils")
local FsUtils = require("lib.fs_utils")
local ScriptUtils = require("lib.script_utils")
local StrUtils = require("lib.str_utils")

function M.load(args)
  args = DictUtils.merge({
    prefix = "",
    exclude = {},
  }, args)
  local lst = FsUtils.get_all_files(ScriptUtils.root_path .. args.prefix:gsub("%.", "/"))
  for _,f in ipairs(lst) do
    local exclude = false
    for __,e in ipairs(args.exclude) do
      if StrUtils.starts_with(f, e) then
        exclude = true
      end
    end
    if StrUtils.ends_with(f, ".lua") and not exclude then
      f = f:sub(0, -5)
      f = f:gsub("/", ".")
      require(args.prefix .. f)
    end
  end
end

return M
