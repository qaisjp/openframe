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

function Team:New(teamName, r, g, b)
	return self:toObject( createTeam(teamName, r, g, b) )
end

function Team:Count()
	return countPlayersInTeam( self.element )
end

function Team:Players()
	return getPlayersInTeam( self.element )
end

function Team:Color(r, g, b)
	if r then
		return setTeamColor ( self.element, r, g, b )
	end
	return getTeamColor ( self.element )
end

function Team:FF(bool)
	if bool then
		return setTeamFriendlyFire ( self.element, bool )
	end
	return getTeamFriendlyFire ( self.element )
end
]])