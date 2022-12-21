local M = {}

local dict_utils = require("lib.dict_utils")

M.ObjectBase = {
  fields = {},
  _meta = { __index = {} },
  extend = function(cls, args)
    args = dict_utils.merge({
      fields = {},
      static = {},
    }, args)
    local rst = dict_utils.merge(cls, args.static)
    rst.fields = dict_utils.merge(rst.fields, args.fields)
    rst._meta = { __index = rst.fields }
    rst.base = cls
    return rst
  end,
  new = function(cls)
    local rst = {}
    setmetatable(rst, cls._meta)
    return rst
  end,
}

M.Object = M.ObjectBase:extend({
  fields = {
    _init = function(self)
    end,
    _first_init = function(self)
    end,
    _clear = function(self)
    end,
    release = function(self)
      self.cls:delete(self)
    end,
    equal = function(self, rhs)
      return self == rhs
    end,
  },
  static = {
    _cache = {},
    _new = function(cls)
      if #cls._cache == 0 then
        return M.ObjectBase:new()
      else
        local rst = cls._cache[#cls._cache]
        cls._cache[#cls._cache] = nil
        return rst
      end
    end,
    new = function(cls, ...)
      local rst = cls:_new()
      rst:_init(...)
    end,
    delete = function(cls, obj)
      obj:_clear()
      cls._cache[#cls._cache + 1] = obj
    end,
    extend = function(cls, args)
      args = dict_utils.merge({
        static = { _cache = {} },
      }, args)
      return cls.base.extend(cls, args)
    end,
  },
})

return M
