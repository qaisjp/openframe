do
  local _parent_0 = nil
  local _base_0 = {
    root = function(self)
      return getRootElement()
    end,
    elements_by_type = function(self, type, root, streamed_in)
      return getElementsByType(self.element, type, root, streamed_in)
    end,
    by_id = function(self, id, index)
      return getElementByID(id, index)
    end,
    destroy = function(self)
      return destroyElement(self.element)
    end,
    radius = function(self)
      return getElementRadius(self.element)
    end,
    low_lod = function(self)
      return isElementLowLOD(self.element)
    end,
    syncer = function(self)
      return isElementSyncer(self.element)
    end,
    syncer = function(self)
      return isElementSyncer(self.element)
    end,
    on_screen = function(self)
      return isElementOnScreen(self.element)
    end,
    ["local"] = function(self)
      return isElementLocal(self.element)
    end,
    attached = function(self)
      return isElementAttached(self.element)
    end,
    colshape = function(self)
      return getElementColShape(self.element)
    end,
    within_colshape = function(self)
      return isElementWithinColShape(self.element, shape)
    end,
    type = function(self)
      return getElementType(self.element)
    end,
    streamed_in = function(self)
      return isElementStreamedIn(self.element)
    end,
    children = function(self, type)
      return getElementChildren(self.element, type)
    end,
    children_count = function(self)
      return getElementChildrenCount(self.element)
    end,
    bounding_box = function(self)
      return getElementBoundingBox(self.element)
    end,
    attached_to = function(self)
      return getElementAttachedTo(self.element)
    end,
    attached_elements = function(self)
      return getElementAttachedElements(self.element)
    end,
    attached_offsets = function(self)
      return getElementAttachedOffsets(self.element)
    end,
    child = function(self, index)
      return getElementChild(self.element, index)
    end,
    distance_from_centre_of_mass_to_base_of_model = function(self)
      return getElementDistanceFromCentreOfMassToBaseOfModel(self.element)
    end,
    dfcomtbom = function(self)
      return getElementDistanceFromCentreOfMassToBaseOfModel(self.element)
    end,
    attach = function(self, ele, xp, yp, zp, xr, yr, zr)
      return attachElements(self.element, ele, xp, yp, zp, xr, yr, zr)
    end,
    detach = function(self, ele)
      return detachElements
    end,
    position = function(self, x, y, z, warp)
      if x and y and z then
        return setElementPosition(self.element, x, y, z, warp)
      end
      return getElementPosition(self.element)
    end,
    rotation = function(self, x, y, z, rotOrder, conform)
      if x and y and z then
        return setElementRotation(self.element, x, y, z, rotOrder, conform)
      end
      return getElementRotation(self.element, x)
    end,
    alpha = function(self, alpha)
      if alpha then
        return setElementAlpha(self.element, alpha)
      end
      return getElementAlpha(self.element)
    end,
    dimension = function(self, dim)
      if dim then
        return setElementDimension(self.element, dim)
      end
      return getElementDimension(self.element)
    end,
    health = function(self, amount)
      if amount then
        return setElementHealth(self.element, amount)
      end
      return getElementHealth(self.element)
    end,
    velocity = function(self, x, y, z)
      if x and y and z then
        return setElementVelocity(self.element, x, y, z)
      end
      return getElementVelocity(self.element)
    end,
    double_sided = function(self, state)
      if state then
        return setElementDoubleSided(self.element, state)
      end
      return getElementDoubleSided(self.element)
    end,
    collidable_with = function(self, ele, enabled)
      if enabled then
        return setElementCollidableWidth(self.element, ele, enabled)
      end
      return isElementCollidableWidth(self:element(ele))
    end,
    model = function(self, id)
      if id then
        return setElementModel(self.element, id)
      end
      return getElementModel(self.element)
    end,
    interior = function(self, interior)
      if interior then
        return setElementInterior(self.element, interior)
      end
      return getElementInterior(self.element)
    end,
    streamable = function(self, state)
      if state then
        return setElementStreamable(self.element, state)
      end
      return getElementStreamable(self.element)
    end,
    collisions_enabled = function(self, enabled)
      if enabled then
        return setElementCollisionsEnabled(self.element, enabled)
      end
      return getElementCollisionsEnabled(self.element)
    end,
    data = function(self, k, v, sync)
      if k and v then
        return setElementData(self.element, k, v, sync)
      end
      return getElementData(self.element, k, v)
    end,
    low_lod_element = function(self, ele)
      if ele then
        return setLowLODElement(self.element, ele)
      end
      return getLowLODElement(self.element)
    end,
    id = function(self, id)
      if id then
        return setElementID(self.element, id)
      end
      return getElementID(self.element)
    end,
    parent = function(self, parent)
      if parent then
        return setElementParent(self.element, parent)
      end
      return getElementParent(self.element)
    end,
    frozen = function(self, state)
      if state then
        return setElementFrozen(self.element, state)
      end
      return isElementFrozen(self.element)
    end
  }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(self, type, id)
      self.element = createElement, type, id
    end,
    __base = _base_0,
    __name = "BaseElement",
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
  BaseElement = _class_0
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
return patch(BaseElement)
