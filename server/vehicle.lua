push([[
Vehicle = Class:Create(Element)

function Vehicle:toObject(element)
	object = Class:Create(self)
	
	object.element = element
	
	return object
end
]])