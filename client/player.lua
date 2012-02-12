push([[
Player = Class:Create(Element)

_getLocalPlayer = getLocalPlayer

function getLocalPlayer()
	return Player:toObject(_getLocalPlayer())
end

function Player:toObject(element)
	object = Class:Create(self)
	
	object.element = element
	
	return object
end

function Player:Name()
	return getPlayerName(self.element)
end

function Player:Team()
	return getPlayerTeam(self.element)
end

function Player:Data(k, v, sync)
	if v then
		return setElementData(self.element, k, v, sync)
	end
	
	return getElementData(self.element, k)
end

localPlayer = getLocalPlayer()
]])