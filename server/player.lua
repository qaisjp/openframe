push([[
Player = Class:Create(Element)

function Player:toObject(element)
	object = Class:Create(self)
	
	object.element = element
	
	return object
end

function Player:Camera()
	camera = Class:Create(Camera)
	
	camera.player = self
	
	return object
end

function Player:Name(value)
	if value then
		return setPlayerName(self.element, value)
	end
	return getPlayerName(self.element)
end

function Player:Team(value)
	if value then
		return setPlayerTeam(self.element, value.element)
	end
	
	return getPlayerTeam(self.element)
end

function Player:giveWeapon(id, ammo, current)
	return giveWeapon ( self.element, id, ammo, current )
end
]])