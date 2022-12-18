local M = {}

local dict_helper = require("lib.dict_helper")

M.ObjectBase = {
  fields = {
    _init = function(self)
    end,
    _create = function(self)
    end,
    _clear = function(self)
    end,
  },
  extend = function(cls, args)
    args = dict_helper.merge({
      fields = {},
      static = {},
    }, args)
    local rst = dict_helper.merge(cls, args.static)
    rst.fields = dict_helper.merge(rst.fields, args.fields)
    return rst
  end
}

M.Object = M.ObjectBase:extend({
  fields = {
  },
  static = {
    _cache = {},
    _create = function(cls)
    end,
    create = function(cls, ...)
    end,
  },
})

return M
