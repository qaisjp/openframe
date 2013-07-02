initiate_object = (object, ...) ->
	func = loadstring "return function(...) return " .. object .. "(...) end"
	instanceFunc = func!

	instance = instanceFunc ...

	element = Element "OpenframeObject", object

	element\data "instance", instance, false

	element.element

call_object_function = (object, func, ...) ->
	instance = getElementData object, "instance"

	func = loadstring "return function(instance, ...) return instance:" .. func .. "(...) end"
	instanceFunc = func!

	instanceFunc instance, ...