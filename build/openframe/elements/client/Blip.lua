do
  local element
  local _parent_0 = Element
  local _base_0 = {
    color = function(self, color)
      if color == nil then
        color = nil
      end
      if color == nil then
        return getBlipColor(self.element)
      else
        return setBlipColor(self.element, color)
      end
    end,
    icon = function(self, icon)
      if icon == nil then
        icon = nil
      end
      if icon == nil then
        return getBlipIcon(self.element)
      else
        return setBlipIcon(self.element, icon)
      end
    end,
    size = function(self, size)
      if size == nil then
        size = nil
      end
      if size == nil then
        return getBlipSize(self.element)
      else
        return setBlipSize(self.element, size)
      end
    end,
    ordering = function(self, order)
      if order == nil then
        order = nil
      end
      if order == nil then
        return getBlipOrdering(self.element)
      else
        return setBlipOrdering(self.element, order)
      end
    end,
    visible_distance = function(self, distance)
      if distance == nil then
        distance = nil
      end
      if distance == nil then
        return getBlipVisibleDistance(self.element)
      else
        return setBlipVisibleDistance(self.element, distance)
      end
    end
  }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(self, ...)
      local arguments = {
        ...
      }
      if argument[0]['element'] then
        arguments[0] = arguments[0]['element']
        self.element = createBlipAttachedTo(unpack(arguments))
      else
        self.element = createBlip(...)
      end
    end,
    __base = _base_0,
    __name = "Blip",
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
  local self = _class_0
  element = nil
  if _parent_0 and _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Blip = _class_0
  return _class_0
end
