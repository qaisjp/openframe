local Pickup
do
  local _parent_0 = Element
  local _base_0 = {
    ammo = function(self)
      return getPickupAmmo(self.element)
    end,
    amount = function(self)
      return getPickupAmmount(self.element)
    end,
    weapon = function(self)
      return getPickupWeapon(self.element)
    end,
    type = function(self, type, var, ammo)
      if type then
        return setPickupType(self.element, type, var, ammo)
      end
      return getPickupType(self.element)
    end
  }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(self, x, y, z, type, var, respawn, ammo)
      self.element = createPickup(x, y, z, type, var, respawn, ammo)
    end,
    __base = _base_0,
    __name = "Pickup",
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
  Pickup = _class_0
  return _class_0
end
