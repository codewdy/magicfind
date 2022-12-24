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
    rst.fields._class = rst
    rst._meta = { __index = rst.fields }
    rst.base = cls
    return rst
  end,
  new = function(cls)
    local rst = {}
    setmetatable(rst, cls._meta)
    return rst
  end,
  is_based_of = function(cls, src_cls)
    if cls == src_cls then
      return true
    elseif cls == M.ObjectBase then
      return false
    else
      return cls.base:is_based_of(src_cls)
    end
  end,
}

M.Object = M.ObjectBase:extend{
  fields = {
    _init = function(self)
    end,
    _first_init = function(self)
    end,
    _clear = function(self)
    end,
    release = function(self)
      self._class:delete(self)
    end,
    is_instance = function(self, cls)
      return self.cls:is_instance(cls)
    end,
    equal = function(self, rhs)
      return self == rhs
    end,
  },
  static = {
    _cache = {},
    _new = function(cls)
      if #cls._cache == 0 then
        local rst = M.ObjectBase.new(cls)
        rst:_first_init()
        return rst
      else
        local rst = cls._cache[#cls._cache]
        cls._cache[#cls._cache] = nil
        return rst
      end
    end,
    new = function(cls, ...)
      local rst = cls:_new()
      rst:_init(...)
      return rst
    end,
    delete = function(cls, obj)
      obj:_clear()
      cls._cache[#cls._cache + 1] = obj
    end,
    extend = function(cls, args)
      args = dict_utils.merge({
        static = { _cache = {} },
      }, args)
      return M.ObjectBase.extend(cls, args)
    end,
  },
}

return M
