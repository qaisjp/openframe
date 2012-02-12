push([[
-----------------------------------------------------------
--- /client/gui/window_class.lua                        ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: Window Class
-- Class which allows to easily create windows.
Window = {  };
Window.__index = Window;

--	Function: Window:Create
--	Creates a window
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the window
--     height - (float/integer) Height of the window
--
--  Optional arguments:
--     text - (string) Text placed in the window
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is window object
function Window:Create( x, y, width, height, text, relative )
	local wnd = {
		gui = 		false,
		_movable = 	true,
		_sizable = 	true,
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
		onmouseenter =	{  },
		onmouseleave = 	{  },
		cursorovergui = false
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if
		(
		  ( i ~= "__index" ) and
		  ( i ~= "Dragable" ) and
		  ( i ~= "Font" )
		)
		then
			wnd[ i ] = f;
		end
	end
	
	for i, f in pairs( WindowAndTab ) do
		if( i ~= "__index" ) then
			wnd[ i ] = f;
		end
	end
	
	wnd.gui = guiCreateWindow( x, y, width, height, text, ( type( relative ) == "boolean" ) and relative or false );
	if( wnd.gui ) then
		setmetatable( wnd, self );
		self.__index = self;
		
		addEventHandler( "onClientGUIClick", 
			wnd.gui,
			function( mouseBtn, state, x, y )
				if type( wnd.onclick ) == "table" then
					for i, f in pairs( wnd.onclick ) do
						f( wnd, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			wnd.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = wnd;
				if type( wnd.onmouseenter ) == "table" then
					for _, f in pairs( wnd.onmouseenter ) do
						if type( f ) == "function" then
							f( wnd, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			wnd.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = false; 
				if type( wnd.onmouseleave ) == "table" then
					for _, f in pairs( wnd.onmouseleave ) do
						if type( f ) == "function" then
							f( wnd, x, y );
						end
					end
				end
			end, 
			false
		)
		return wnd;
	end
	return false;
end

--	Function: Window:Movable
--	Returns or sets the "movable" property
--
--  Optional arguments:
--     status - (bool) "movable" property to set
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current state.
function Window:Movable( status )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( status ) == "boolean" ) then
		if guiWindowSetMovable( self.gui, status ) then
			self._movable = status;
			return true;
		end
	end
	return self._movable;
end

--	Function: Window:Sizeable
--	Returns or sets the "sizeable" property
--
--  Optional arguments:
--     status - (bool) "sizeable" property to set
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current state.
function Window:Sizable( status )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( status ) == "boolean" ) then
		if guiWindowSetSizable( self.gui, status ) then
			self._sizable = status;
			return true;
		end
	end
	return self._sizable;
end

]])