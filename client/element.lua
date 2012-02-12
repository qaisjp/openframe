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

]])