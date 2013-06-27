local Water
do
  local _parent_0 = Element
  local _base_0 = {
    vertex_position = function(self, vertexIndex, x, y, z)
      if vertexIndex and x and y and z then
        return setWaterVertexPosition(self.element, vertexIndex, x, y, z)
      end
      return getWaterVertexPosition(self:element(vertexIndex))
    end
  }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(self, x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4, bShallow)
      self.element = createWater(x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4, bShallow)
    end,
    __base = _base_0,
    __name = "Water",
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
  Water = _class_0
  return _class_0
end
