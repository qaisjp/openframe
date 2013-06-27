local Weapon
do
  local _parent_0 = Element
  local _base_0 = {
    fire = function(self)
      return fireWeapon(self.element)
    end,
    reset_firing_rate = function(self)
      return resetWeaponFiringRate(self.element)
    end,
    enable_effect = function(self, name, enabled)
      return setSoundEffectEnabled(name, enabled)
    end,
    property = function(self, id, skill, property, value)
      if value then
        return setWeaponProperty(self.element, id, skill, property, value)
      end
      return getWeaponProperty(self.element, id, skill, property)
    end,
    target = function(self, target, component)
      if target and component then
        return setWeaponTarget(self.element, target, component)
      end
      return getWeaponTarget(self.element)
    end,
    state = function(self, state)
      if state then
        return setWeaponState(self.element, state)
      end
      return getWeaponState(self.element)
    end,
    owner = function(self, owner)
      if owner then
        return setWeaponOwner(self.element, owner)
      end
      return getWeaponOwner(self.element)
    end,
    flags = function(self, flag, value)
      if flag and value then
        return setWeaponFlags(self.element, flag, value)
      end
      return getWeaponFlags(self.element, flag)
    end,
    firing_rate = function(self, rate)
      if rate then
        return setWeaponFiringRate(self.element, rate)
      end
      return getWeaponFiringRate(self.element)
    end,
    clip_ammo = function(self, clip_ammo)
      if clip_ammo then
        return setWeaponClipAmmo(self.element, clip_ammo)
      end
      return getWeaponClipAmmo(self.element)
    end,
    ammo = function(self, ammo)
      if ammo then
        return setWeaponpAmmo(self.element, ammo)
      end
      return getWeaponAmmo(self.element)
    end
  }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(self, type, x, y, z)
      self.element = createWeapon(type, x, y, z)
    end,
    __base = _base_0,
    __name = "Weapon",
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
  Weapon = _class_0
  return _class_0
end
