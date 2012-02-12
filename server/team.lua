push([[
Team = Class:Create(Element)

function Team:toObject(element)
	object = Class:Create(self)
	
	object.element = element
	
	return object
end

function Team:fromName(value)
	return self:toObject(getTeamFromName(value))
end

function Team:Name(value)
	if value then
		return setTeamName(self.element, value)
	end
	return getTeamName(self.element)
end
]])