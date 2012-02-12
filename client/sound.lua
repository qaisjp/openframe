push([[
Sound = Class:Create()

function Sound:toObject(element)
	object = Class:Create(self)
	
	object.element = element
	
	return object
end

function Sound:Play(path, rep)
	local element = playSound(path, rep)
	
	return Sound:toObject(element)
end

function Sound:Volume(value)
	if value then
		return setSoundVolume(Sound.element, value)
	end
	return getSoundVolume(self.element)
end

function Sound:Speed(value)
	if value then
		return setSoundSpeed(Sound.element, value)
	end
	return getSoundSpeed(self.element)
end
]])