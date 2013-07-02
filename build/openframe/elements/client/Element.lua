do
  local _parent_0 = BaseElement
  local _base_0 = { }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(self, type, id)
      return _parent_0.__init(self, type, id)
    end,
    __base = _base_0,
    __name = "Element",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil and _parent_0 then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0 and _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Element = _class_0
end
local patch
patch = function(klass)
  getmetatable(klass).__call = function(cls, ...)
    local self = setmetatable({ }, cls.__base)
    local newself = cls.__init(self, ...)
    if newself then
      self = setmetatable(newself, cls.__base)
    end
    return self
  end
end
return patch(Element)
