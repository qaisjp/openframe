local initiate_object
initiate_object = function(object, ...)
  local func = loadstring("return function(...) return " .. object .. "(...) end")
  local instanceFunc = func()
  local instance = instanceFunc(...)
  local element = Element("OpenframeObject", object)
  element:data("instance", instance, false)
  return element.element
end
local call_object_function
call_object_function = function(object, func, ...)
  local instance = getElementData(object, "instance")
  func = loadstring("return function(instance, ...) return instance:" .. func .. "(...) end")
  local instanceFunc = func()
  return instanceFunc(instance, ...)
end
