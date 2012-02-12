push([[
-----------------------------------------------------------
--- /client/gui/tabpanel_class.lua                      ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: TabPanel Class
-- Class which allows to easily create tabpanels.
TabPanel = {  };
TabPanel.__index = TabPanel;

--	Function: TabPanel:Create
--	Creates a tabpanel
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the tabpanel
--     height - (float/integer) Height of the tabpanel
--
--  Optional arguments:
--     relative - (bool) Are the x/y/width/height values relative?
--     parent - (GUI) Parent of the image
--	   
--	Returns:
--		The result is a tab panel.
function TabPanel:Create( x, y, width, height, relative, parent )
	local tabpanel = {
		gui = false,
		tabs = { }
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if
		(
		  ( i ~= "__index" ) and
		  ( i ~= "Dragable" ) and
		  ( i ~= "Text" ) and
		  ( i ~= "Font" )
		  --( i ~= "" )
		)
		then
			tabpanel[ i ] = f;
		end
	end

	tabpanel.gui = guiCreateTabPanel( x, y, width, height, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( tabpanel.gui ) then
		setmetatable( tabpanel, self );
		self.__index = self;
		return tabpanel;
	end
	return false;
end

--	Function: TabPanel:AddTab
--	Adds a new tab to the tabpanel
--
--  Required arguments:
--     text - (string) Name of the tab to load
--	   
--	Returns:
--	   A tab object, or false if failed to add.
function TabPanel:AddTab( text )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( text ) == "string" ) then
		local tempTab = Tab:Create( text, self.gui );
		if( tempTab ) then 
			table.insert( self.tabs, tempTab );
			return tempTab;
		end
	end
	return false;
end

--	Function: TabPanel:DeleteTab
--	Deletes a tab from the tabpanel
--
--  Required arguments:
--     tab (GUI) - a tab to remove
--	   
--	Returns:
--	   True if removed, false if not.
function TabPanel:DeleteTab( tab )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	
	if type( tab ) == "table" then
		tab = tab.gui;
	end
	
	if( type( tab ) == "userdata" ) then
		if ( destroyElement( tab ) ) then
			for k, v in pairs( self.tabs ) do
				if v == tab then
					table.remove( self.tabs, k );
					break;
				end
			end
			return true;
		end
	end
	return false;
end

--	Function: TabPanel:GetTabs
--	Gets all tabs and returns them
--	   
--	Returns:
--	   Table with all tabs
function TabPanel:GetTabs( )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	return self.tabs;
end

]])