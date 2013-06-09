local RadarArea
do
  local _parent_0 = Element
  local _base_0 = {
    inside = function(self, x, y)
      return isInsideRadarArea(self.element, x, y)
    end,
    amount = function(self)
      return getPickupAmmount(self.element)
    end,
    weapon = function(self)
      return getPickupWeapon(self.element)
    end,
    color = function(self, r, g, b, a)
      if r and g and b and a then
        return setRadarAreaColor(self.element, r, g, b, a)
      end
      return getRadarAreaColor(self.element)
    end,
    flashing = function(self, bool)
      if bool then
        return setRadarAreaFlashing(self.element, bool)
      end
      return isRadarAreaFlashing(self.element)
    end,
    size = function(self, x, y)
      if x and y then
        return setRadarAreaSize(self.element, x, y)
      end
      return getRadarAreaSize(self.element)
    end
  }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(self, lx, by, sx, sy, r, g, b, a)
      self.element = createRadarAreap(lx, by, sx, sy, r, g, b, a)
    end,
    __base = _base_0,
    __name = "RadarArea",
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
  RadarArea = _class_0
  return _class_0
end
