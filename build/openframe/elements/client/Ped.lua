do
  local _parent_0 = Element
  local _base_0 = {
    choking = function(self)
      return isPedChoking(self.element)
    end,
    ducked = function(self)
      return isPedDucked(self.element)
    end,
    warp = function(self, veh, seat)
      return warpPedIntoVehicle(self.element, veh, seat)
    end,
    armor = function(self)
      return getPedArmor(self.element)
    end,
    knocked_off_bike = function(self, can)
      if can then
        return setPedCanBeKnockedOffBike(self.element, can)
      end
      return canPedBeKnockedOffBike(self.element)
    end,
    headless = function(self, state)
      if state then
        return setPedHeadless(self.element, state)
      end
      return setPedHeadless(self.element)
    end,
    oxygen_level = function(self, oxygen)
      if oxygen then
        return setPedOxygenLevel(self.element, oxygen)
      end
      return getPedOxygenLevel(self.element)
    end,
    animation = function(self, block, anim, time, loop, update, interruptable, freeze)
      if block ~= nil then
        return setPedAnimation(self.element, block, anim, time, loop, update, interruptable, freeze)
      end
      return getPedAnimatino(self.element)
    end,
    add_blip = function(self, icon)
      return Blip(self, icon)
    end
  }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(self, model, x, y, z, rot)
      self.element = createPed(model, x, y, z, rot)
    end,
    __base = _base_0,
    __name = "Ped",
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
  Ped = _class_0
  return _class_0
end
