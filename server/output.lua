push([[
Output = Class:Create()

function Output:Chat(text, who, r, g, b)
	if type(who) == "table" then
		who = who.element
	end
	
	return outputChatBox(text, who, r, g, b);
end

function Output:Console(text, who)
	if type(who) == "table" then
		who = who.element
	end
	
	return outputConsole(text, who);
end

function Output:Debug(text, level, r, g, b)
	return outputDebugString ( text, level, r, g, b );
end

function Output:Log(text)
	return outputServerLog ( text )
end
]])