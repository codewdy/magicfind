local M = {}

local DictUtils = require("lib.dict_utils")

local class_meta = {
  __call = function(self, ...)
    return self:new(...)
  end,
}

M.ObjectBase = {
  fields = {},
  _meta = { __index = {} },
  extend = function(cls, fields)
    fields = DictUtils.merge({ __static = {} }, fields)
    local rst = DictUtils.merge(cls, fields.__static)
    fields.__static = nil
    rst.fields = DictUtils.merge(rst.fields, fields)
    rst.fields._class = rst
    rst._meta = { __index = rst.fields }
    rst.base = cls
    setmetatable(rst, class_meta)
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

setmetatable(M.ObjectBase, class_meta)

M.Object = M.ObjectBase:extend{
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
  __static = {
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
    extend = function(cls, fields)
      fields.__static = DictUtils.merge({
        _cache = {},
      }, fields.__static)
      return M.ObjectBase.extend(cls, fields)
    end,
  },
}

return M
