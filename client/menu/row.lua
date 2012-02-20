--[[
	Part of openFrame project
	Written by Lord Azamath. Additional changes by Noddy
	
	- Classes for creating various menus.
	- Creating menus, dynamically managing rows, various functions for row hover, row click.
]]--

push([[
Row = Class:Create()

function Row:Title(title)
	if title then
		self.title = title
		guiSetText(self.label,title)
		return self
	end
	return self.title
end

function Row:Property(property,value) 
	if value then
		if not self.properties then self.properties = {} end
		self.properties[property] = value
		if property == "header" and value then
			self:setFont("default-bold-small")
			guiSetEnabled(self.label,false)
		elseif property == "sub Menu" and value then
			guiSetText(self.label, guiGetText(self.label).." >")
		end
		return self
	end
	return self.properties and self.properties[property] or false
end -- Hardcoded properties: sub Menu, header, separator

function Row:Click(func) 
	if func then
		if not self.onClick then self.onClick = {} end
		table.insert(self.onClick,func)
		return self
	end
	return self.onClick or {}
end

function Row:Enter(func) 
	if func then
		if not self.onEnter then self.onEnter = {} end
		table.insert(self.onEnter,func)
		return self
	end
	return self.onEnter or {}
end

function Row:Leave(func) 
	if func then
		table.insert(self.onLeave or {}, func)
		return self
	end
	return self.onLeave or {}
end
function Row:HoverColor(r,g,b) 
	if r then
		self.hoverColor = {r,g,b}
		return self
	end
	return self.hoverColor
end
function Row:Color(r,g,b) 
	if r then
		self.color = {r,g,b}
		guiLabelSetColor(self.label,r,g,b)
		return self
	end
	return self.color
end
function Row:HoverFont(font) 
	if font then
		self.hoverFont = font
		return self
	end
	return self.hoverFont
end
function Row:Font(font)
	if font then
		self.font = font
		guiSetFont(self.label, font)
		return self
	end
	return self.font
end

function Row:addSubMenu(title)
	local parent
	for k,v in ipairs(Menus) do
		for i,r in ipairs(v) do
			if r == self then
				parent = v
				break
			end
		end
	end
	local level = parent:getProperty("subMenu level")
	if not level then level = 1 end
	self:setProperty("sub Menu",true)
	local o = Menu:create(title)
	o:setProperty("subMenu level",level + 1)
	self:addOnEnter(function () o:show() end)
	self.subMenu = o
	-- calculate it's position
	local x,y = guiGetPosition(getElementParent(self.label),false)
	local w,h = guiGetSize(getElementParent(self.label),false)
	o:setPosition(x+w - 1,y + 15,false)
	--self:addOnLeave(function () o:hide() end)
	return o
end
function Row:Position(bool)
	return guiGetPosition(self.label,false or bool)
end
function Row:Align(horizontal, vertical)
	if horizontal then
		guiLabelSetHorizontalAlign(self.label,horizontal)
	end
	if vertical then
		guiLabelSetVerticalAlign(self.label,vertical)
	end	
	return self
end
function getRowFromLabel(label)
	for k,v in ipairs(Menus) do
		for i, Row in ipairs(v) do
			if Row.label == label then
				return Row,v
			end
		end
	end
	return false
end
function RowEnterHandler()
	if getElementType(source) == "gui-label" then
		local Row,theMenu = getRowFromLabel(source)
		if not Row then return end
		-- check for submenus
		local subMenus = {}
		for k,v in ipairs(Menus) do
			for i,r in ipairs(v) do
				if r.subMenu then
					table.insert(subMenus,r.subMenu)
				end
			end
		end
		local level = theMenu:getProperty("subMenu level") or 1
		for k,v in ipairs(subMenus) do
			if v:getProperty("subMenu level") > level then
				v:hide()
			end
		end	
		-- end
		local colors = Row:getHoverColor()
		guiLabelSetColor(source,colors[1],colors[2],colors[3])
		for k, func in ipairs(Row:getOnEnter()) do
			func(Row)
		end
	end
end
function RowLeaveHandler()
	if getElementType(source) == "gui-label" then
		local Row = getRowFromLabel(source)
		if Row then
			local colors = Row:getColor()
			guiLabelSetColor(source,colors[1],colors[2],colors[3])
			for k, func in ipairs(Row:getOnLeave()) do
				func(Row)
			end
		end
	end
end
function RowClickHandler(button, state)
	if getElementType(source) == "gui-label" and button == "left" and state == "up" then
		local Row = getRowFromLabel(source)
		for k, func in ipairs(Row:getOnClick()) do
			func(Row)
		end
	end
end
addEventHandler("onClientMouseEnter", root, RowEnterHandler)
addEventHandler("onClientMouseLeave", root, RowLeaveHandler)
addEventHandler("onClientGUIClick", root, RowClickHandler)
]])