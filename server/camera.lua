push([[
Camera = Class:Create(Element)

function Camera:Player()
	return self.player
end

function Camera:Fade(fadeIn, timeToFade, r, g, b)
	return fadeCamera ( self.player, fadeIn, timeToFade, r, g, b) 
end

function Camera:Target(target)
	if target then
		setCameraTarget ( self.player, target.player )
		return
	end
	
	return getCameraTarget ( self.player)
end

function Camera:Matrix(positionX, positionY, positionZ, lookAtX, lookAtY, lookAtZ, roll, fov)
	if positionX then
		setCameraMatrix ( self.player, positionX, positionY, positionZ, lookAtX, lookAtY, lookAtZ, roll, fov )
		return
	end

	return getCameraMatrix ( self.player )
end

function Camera:Interior(int)
	if int then
		setCameraInterior ( self.player, int )
		return
	end
	
	return getCameraInterior ( self.player )
end

function Player:giveWeapon(id, ammo, current)
	return giveWeapon ( self.element, id, ammo, current )
end
]])
