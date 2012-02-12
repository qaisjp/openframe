push([[
Element = Class:Create()

function Element:toObject(element)
	t = getElementType(element)
	
	if t == "player" then
		return Player:toObject(element)
	end
	
	if t == "team" then
		return Team:toObject(element)
	end
end

function Element:Rotation(x,y,z)
	if x and y and z then
		return setElementRotation(self.element, x,y,z)
	end
	
	return getElementRotation(self.element)
end

function Element:Interior(int)
	if int then
		return setElementInterior(self.element, int)
	end
	
	return getElementInterior(self.element)
end

function Element:Position(x,y,z)
	if x and y and z then
		return setElementPosition(self.element, x,y,z)
	end
	
	return getElementPosition(self.element)
end

function Element:Health(value)
	if value then
		return setElementHealth(self.element, value)
	end
	
	return getElementHealth(self.element)
end

function Element:Data(k, v)
	if v then
		return setElementData(self.element, k, v)
	end
	
	return getElementData(self.element, k)
end

function Element:Chat(text, r, g, b)
	return Output:Chat(text, self, r, g, b)
end
]])