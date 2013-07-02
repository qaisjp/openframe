if not getModuleInfo("mtasa-curl") then
  return 
end
local Curl
do
  local pCurl
  local _parent_0 = nil
  local _base_0 = {
    setopt_table = function(options)
      for option, value in pairs(options) do
        curl_setopt(self.pCurl, option, value)
      end
    end,
    setopt = function(option, value)
      return curl_setopt(self.pCurl, option, value)
    end
  }
  _base_0.__index = _base_0
  if _parent_0 then
    setmetatable(_base_0, _parent_0.__base)
  end
  local _class_0 = setmetatable({
    __init = function(url)
      if url == nil then
        url = ""
      end
      self.pCurl = curl_init(url)
    end,
    __base = _base_0,
    __name = "Curl",
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
  pCurl = nil
  if _parent_0 and _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Curl = _class_0
  return _class_0
end
