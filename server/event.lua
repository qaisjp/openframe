push([[
Event = Class:Create()
Event.handlers = {}

function Event:Create(name, create, other)
	if other == nil then other = true end
	
	if create then
		addEvent(name, other)
	end
	
	object = Class:Create(self)
	
	object.name = name
	
	if not Event.handlers[name] then
		Event.handlers[name] = {}
	end
	
	return object;
end

function Event:Handle(func, element)
	if element == nil then element = getRootElement() end
	
	if not self.handlers[self.name][element] then
		self.handlers[self.name][element] = {};
	end
	
	if #self.handlers[self.name][element] == 0 then
		addEventHandler(self.name, element, self.onTriggered )
	end
	
	
	table.insert(self.handlers[self.name][element], { ["fn"] = func, ["element"] = element })
	
	return self;
end

function Event:Remove(func, element)
	if element == nil then element = getRootElement() end
	
	if not Event.handlers[self.name][element] then
		return false;
	end
	
	-- Let's find it
	i = false
	
	for k,v in ipairs(Event.handlers[self.name][element]) do
		if v.fn == func then
			i = k
		end
	end
	
	if not i then
		return false;
	end
	
	table.remove(Event.handlers[self.name][element], i)
	return true;
end

function Event.onTriggered(...)
	if Event.handlers[eventName][this] then
		for k,v in ipairs(Event.handlers[eventName][this]) do
			v.fn(Element:toObject(source), ...)
		end
	end
end

function Event:ClientTrigger(element, ...)
	if type(element) == "table" then element = element.element end

	return triggerClientEvent(element, self.name, element, ...)
end

function Event:Trigger(element, ...)
	if type(element) == "table" then element = element.element end

	return triggerEvent(self.name, element, ...)
end

function index_extend(t, key)
	if key:sub(1,2) == "on" then		
		if key:sub(1, 8) == "onClient" then
			return Event:Create(key, true);
		else
			return Event:Create(key);
		end
	end
    return nil;
end

setmetatable(_G, {__index = index_extend})
]])