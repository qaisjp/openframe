local Sound
do
  local _parent_0 = Element
  local _base_0 = {
    length = function(self)
      return getSoundLength(self.element)
    end,
    effects = function(self)
      return setSoundEffects(self.effects)
    end,
    meta_tags = function(self)
      return getSoundMetaTags(self.element)
    end,
    enable_effect = function(self, name, enabled)
      return setSoundEffectEnabled(name, enabled)
    end,
    stop = function(self)
      return stopSound(self.element)
    end,
    bpm = function(self)
      return getSoundBPM(self.element)
    end,
    fft = function(self, samples, bands)
      return getSoundFFTData(self.element, samples, bands)
    end,
    wave = function(self, samples)
      return getSoundWaveData(self.element, samples)
    end,
    level = function(self)
      return getSoundLevelData(self.element)
    end,
    max_distance = function(self, value)
      if value then
        return setSoundMaxDistance(self.element, value)
      end
      return getSoundMaxDistance(self.element)
    end,
    min_distance = function(self, value)
      if value then
        return setSoundMinDistance(self.element, value)
      end
      return getSoundMinDistance(self.element)
    end,
    position = function(self, value)
      if value then
        return setSoundPosition(self.element, value)
      end
      return getSoundPosition(self.element)
    end,
    speed = function(self, value)
      if value then
        return setSoundSpeed(self.element, value)
      end
      return getSoundSpeed(self.element)
    end,
    volume = function(self, value)
      if value then
        return setSoundVolume(self.element, value)
      end
      return getSoundVolume(self.element)
    end,
    paused = function(self, value)
      if value then
        return isSoundPaused(self.element)
      end
      return setSoundPaused(self.element, value)
    end,
    properties = function(self, srate, tempo, pitch, reverse)
      if srate and tempo and pitch and reverse then
        return setSoundProperties(self.element, srate, tempo, pitch, reverse)
      end
      return getSoundProperties(self.element)
    end,
    pan = function(self, value)
      if value then
        return setSoundPan(self.element, value)
      end
      return getSoundPan(self.element)
    end
  }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(self, path, looped, x, y, z)
      if not path or not looped then
        self.element = path
      elseif not x or not y or not z then
        self.element = playSound(path, looped)
      else
        self.element = playSound3D(path, x, y, z, looped)
      end
    end,
    __base = _base_0,
    __name = "Sound",
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
  Sound = _class_0
  return _class_0
end
