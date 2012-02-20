--[[
	Part of openFrame project
	Written by Gamesnert. Additional changes by Noddy
	
	- Classes for creating various graphs
]]--
push([[
Graph = Class:Create()
local graphs = { }

-------------------------------------------------------------------------------------
-- Basic graph management
-------------------------------------------------------------------------------------

function Graph:Create ( width, height )
	local graph = Class:Create(self)
	
	graph.renderTarget = nil
	graph.lineColor    = 0
	graph.lineWidth    = 0
	graph.width        = 0
	graph.height       = 0
	graph.entries      = { }
	graph.entryStep    = 0
	graph.maxEntries   = 0
	graph.maxValue     = 0
	graph.max          = nil
	graph.avg          = nil
	graph.redraw       = false
	
	local success = true
	
	success = success and graph:SetSize ( width, height )
	success = success and graph:SetMaxEntries ( 10 )
	success = success and graph:SetMaxValue ( 100 )
	success = success and graph:SetLineColor ( tocolor ( 255, 0, 0 ) )
	success = success and graph:SetLineWidth ( 1 )
	
	if success then
		table.insert ( graphs, graph )
		return graph
	end
	
	return false
end

function Graph:Delete ( )
	if isElement ( self.renderTarget ) then destroyElement ( self.renderTarget ) end
	
	for index, graph in ipairs ( graphs ) do
		if graph == self then
			table.remove ( graphs, index )
			break
		end
	end
	
	return true
end

function Graph:Clear ( )
	self.entries = { }
	self.redraw = true
	self.max = nil
	self.avg = nil
	
	return true
end

function Graph:AddEntry ( entry )
	if type ( entry ) ~= "number" or entry < 0 then
		return false
	end
	
	if #self.entries >= self.maxEntries then
		table.remove ( self.entries, 1 )
	end
	
	table.insert ( self.entries, entry )
	self.redraw = true
	self.max = nil
	self.avg = nil
	
	return true
end

-------------------------------------------------------------------------------------
-- Changing attributes
-------------------------------------------------------------------------------------
function Graph:Size ( width, height )
	if width then
		if type ( width ) ~= "number" or type ( height ) ~= "number" or width <= 0 or height <= 0 then
			return false
		end
		
		if self:CreateRenderTarget ( width, height ) then
			self.entryStep = self.width / ( self.maxEntries - 1 )
			return true
		end
		
		return false
	end
	
	return self.width, self.height
end

function Graph:MaxValue ( val )
	if val then
		if type ( val ) ~= "number" or val <= 0 then
			return false
		end
		
		self.maxValue = val
		self.redraw = true
		
		return true
	end
	
	return self.maxValue
end

function Graph:MaxEntries ( max )
	if max then
		if type ( max ) ~= "number" or max <= 1 then
			return false
		end
		
		if max < #self.entries then
			for i=1, #self.entries - max do
				table.remove ( self.entries, 1 )
			end
		end
		
		self.maxEntries = max
		self.entryStep = self.width / ( max - 1 )
		self.redraw = true
		self.max = nil
		self.avg = nil
		
		return true
	end

	return self.maxEntries
end

function Graph:LineColor ( color )
	if color then
		if type ( color ) ~= "number" then
			return false
		end
		
		self.lineColor = color
		self.redraw = true
		
		return true
	end
	
	return self.lineColor
end

function Graph:LineWidth ( width )
	if width then
		if type ( width ) ~= "number" or width <= 0 then
			return false
		end
		
		self.lineWidth = width
		self.redraw = true
		
		return true
	end

	return self.lineWidth
end

-------------------------------------------------------------------------------------
-- Getting attributes
-------------------------------------------------------------------------------------

function Graph:GetEntries ( )
	return self.entries
end

function Graph:GetGraphTexture ( )
	return self.renderTarget
end

function Graph:GetAverage ( )
	if self.avg then
		return self.avg
	end
	
	if #self.entries == 0 then
		return math.huge
	end
	
	local total = 0
	for index, value in ipairs ( self.entries ) do
		total = total + value
	end
	
	self.avg = total / #self.entries
	
	return self.avg
end

function Graph:GetMax ( )
	if self.max then
		return self.max
	end
	
	if #self.entries == 0 then
		return math.huge
	end
	
	self.max = math.max ( unpack ( self.entries ) )
	
	return self.max
end

-------------------------------------------------------------------------------------
-- Drawing functions
-------------------------------------------------------------------------------------

function Graph:CreateRenderTarget ( width, height )
	local newRT = dxCreateRenderTarget ( width, height, true )
	if newRT then
		if isElement ( self.renderTarget ) then destroyElement ( self.renderTarget ) end
		
		self.renderTarget = newRT
		self.width  = width
		self.height = height
		self.redraw = true
		
		return true
	end
	
	return false
end


function getGraphs ( )
	return graphs
end


-------------------------------------------------------------------------------------
-- Drawing management
-------------------------------------------------------------------------------------

function Graph:PrepareRenderTarget ( )
	dxSetRenderTarget ( self.renderTarget, true )
	
	local entryCount = #self.entries
	
	-- Prepare zeh variables!
	local lastPosX, lastPosY
	local width, height = self:GetSize ( )
	local lineColor = self:GetLineColor ( )
	local lineWidth = self:GetLineWidth ( )
	local maxValue  = self:GetMaxValue  ( )
	
	for i = entryCount, 1, -1 do
		local entry = self.entries [ i ]
		
		local posX = width  - ( entryCount - i ) * self.entryStep
		local posY = height - height * ( entry / maxValue )
		
		if lastPosX then
			dxDrawLine ( lastPosX, lastPosY, posX, posY, lineColor, lineWidth )
		end
		
		lastPosX = posX
		lastPosY = posY
	end
	
	dxSetRenderTarget ( )
end

local function maintainGraphs ( )
	for index, graph in ipairs ( graphs ) do
		if graph.redraw then
			graph:PrepareRenderTarget ( )
			graph.redraw = false
		end
	end
end
addEventHandler ( "onClientRender", getRootElement ( ), maintainGraphs )
]])