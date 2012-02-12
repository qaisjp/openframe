push([[
Output = Class:Create()

function Output:Chat(text, r, g, b)
	return outputChatBox(text, r, g, b);
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
]])