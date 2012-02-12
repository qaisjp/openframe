push([[
-----------------------------------------------------------
--- /client/gui/tab_class.lua                           ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: Tab Class
-- Class which allows to easily add tabs to tabpanels.
Tab = {  };
Tab.__index = Tab;

--	Function: Tab:Create
--	Creates a image
--	
--	Required Arguments:
--	   text - (string) Name of the tab
--     parent - (GUI) Tabpanel to add the tab into
--	   
--	Returns:
--		The result is a tab object
function Tab:Create( text, parent )
	local tab = {
		gui = false,
		buttons = 		{  },
		checkboxes = 	{  },
		gridlists = 	{  },
		labels = 		{  },
		memos = 		{  },
		progressbars = 	{  },
		radiobuttons = 	{  },
		scrollbars = 	{  },
		staticimages = 	{  },
		tabpanels = 	{  },
		textboxes = 	{  },
		onclick = 		{  },
		onmouseenter = 	{  },
		onmouseleave = 	{  },
		cursorovergui = false
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if
		(
		  ( i ~= "__index" ) and
		  ( i ~= "Dragable" ) and
		  ( i ~= "Font" ) and
		  ( i ~= "Alpha" ) and
		  ( i ~= "Position" ) and
		  ( i ~= "Size" ) and
		  ( i ~= "Visible" )
		)
		then
			tab[ i ] = f;
		end
	end
	
	for i, f in pairs( WindowAndTab ) do
		if ( i ~= "__index" ) then
			tab[ i ] = f;
		end
	end

	tab.gui = guiCreateTab( text, parent );
	if( tab.gui ) then
		setmetatable( tab, self );
		self.__index = self;
		
		addEventHandler( "onClientGUIClick", 
			tab.gui,
			function( mouseBtn, state, x, y )
				if type( tab.onclick ) == "table" then
					for i, f in pairs( tab.onclick ) do
						f( tab, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			tab.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = tab;
				if type( tab.onmouseenter ) == "table" then
					for _, f in pairs( tab.onmouseenter ) do
						if type( f ) == "function" then
							f( tab, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			tab.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = false; 
				if type( tab.onmouseleave ) == "table" then
					for _, f in pairs( tab.onmouseleave ) do
						if type( f ) == "function" then
							f( tab, x, y );
						end
					end
				end
			end, 
			false
		)
		return tab;
	end
	return false;
end

]])