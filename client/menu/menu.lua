push([[
--[[
	Part of openFrame project
	Written by Lord Azamath. Additional changes by Noddy
	
	- Classes for creating various menus.
	- Creating menus, dynamically managing rows, various functions for row hover, row click.
]]--

Menu = Class:Create()
Menus = {
activeMenu = false
}
function Menu:create(name)
	local o = Class:Create(Menu)
	-- set variables
	o.showing = false
	o.name = name
	o.parent = false
	-- GUI
	o.bg = guiCreateStaticImage(0,0,0,0,":openframe/client/menu/black.png",false)
	o:addRow(name):Property("header",true):setAlign("center","center")
	guiSetAlpha(o.bg,0.6)
	o:hide()
	return o
end
function Menu:destroy()
	for k,r in ipairs(self) do
		if r.subMenu then
			r.subMenu:destroy()
		end
	end
	if isElement(self.bg) then
		destroyElement(self.bg)
	end
	for k,v in ipairs(Menus) do
		if v == self then
			table.remove(Menus,k)
			break
		end
	end
	return true
end
function Menu:Position(x,y,bool)
	if y then
		guiSetPosition(self.bg,x,y,false or bool)
		return self
	end
	return guiGetPosition(self.bg,false or x) 
end

function Menu:setSize(w,h,bool)
	if h then
		guiSetSize(self.bg, w,h,false or bool)
		return self 
	end
	return guiGetSize(self.bg, bool or w)
end

function Menu:show () 
	self.showing = true
	Menus.activeMenu = self
	-- GUI
	guiSetVisible(self.bg, true)
	return self
end
function Menu:hide () 
	self.showing = false
	guiSetVisible(self.bg,false)
	if Menus.activeMenu == self then
		Menus.activeMenu = false
	end
	return self
end

-- Syntax: title, onClick function
function Menu:addRow(title, fn) 
	local o = Class:Create(Row)
	o:Title(title)
	o:Property("sub Menu", false)
	o:Property("header",false)
	o:Property("separator",false)
	o:Color(255,255,255)
	o:HoverColor(0,255,0)
	o:Font("default-normal")
	o:HoverFont("default-normal")	
	-- GUI
	local w,y = self:Size(false)
	--outputChatBox(tostring(title))
	o.label = guiCreateLabel(4,y,w,15,title,false,self.bg)
	local w2 = guiLabelGetTextExtent(o.label) + 6
	if w2 > w then
		-- also update header size to make it be in center
		guiSetSize(self[1],w2,15,false)
		guiSetSize(o.label,w2,15,false)
		w = w2
	end
	local h = y + 15
	self:Size(w,h,false)
	
	if fn and type(fn) == "function" then
		if not o.onClick then o.onClick = {} end
		table.insert(o.onClick,fn)
	end
	return o
end
function Menu:Property(prop,v)
	if not self.properties then self.properties = {} end
	if v then
		self.properties[prop] = v
		return self
	end

	return self.properties[prop] or false
end
]])