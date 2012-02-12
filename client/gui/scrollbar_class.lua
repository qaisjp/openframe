push([[
-----------------------------------------------------------
--- /client/gui/scrollbar_class.lua                     ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: ScrollBar Class
-- Class which allows to easily add scrollbars to windows/screen.
ScrollBar = {  };
ScrollBar.__index = ScrollBar;

--	Function: ScrollBar:Create
--	Creates a scrollbar
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the scrollbar
--     height - (float/integer) Height of the scrollbar
--     horizontal - (bool) Is the scrollbar horizontal?
--
--  Optional arguments:
--     relative - (bool) Are the x/y/width/height values relative?
--     parent - (GUI) Parent of the radiobutton
--	   
--	Returns:
--		The result is scrollbar object
function ScrollBar:Create( x, y, width, height, horizontal, relative, parent )
	local scrollbar = {
		gui = false,
		onclick = { },
		onmouseenter = { },
		onmouseleave = { },
		cursorovergui = false
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if
		(
		  ( i ~= "__index" ) and 
		  ( i ~= "Dragable" ) and
		  ( i ~= "Text" ) and
		  ( i ~= "Font" )
		)
		then
			scrollbar[ i ] = f;
		end
	end

	scrollbar.gui = guiCreateScrollBar( x, y, width, height, horizontal, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( scrollbar.gui ) then
		setmetatable( scrollbar, self );
		self.__index = self;
		addEventHandler( "onClientMouseEnter", scrollbar.gui, function( ) GUICollection.guiMouseIsOver = scrollbar;  end, false );
		addEventHandler( "onClientMouseLeave", scrollbar.gui, function( ) GUICollection.guiMouseIsOver = false;  end, false );
		addEventHandler( "onClientGUIClick", 
			scrollbar.gui,
			function( mouseBtn, state, x, y )
				if type( scrollbar.onclick ) == "table" then
					for i, f in pairs( scrollbar.onclick ) do
						f( scrollbar, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			scrollbar.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = scrollbar;
				if type( scrollbar.onmouseenter ) == "table" then
					for _, f in pairs( scrollbar.onmouseenter ) do
						if type( f ) == "function" then
							f( scrollbar, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			scrollbar.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = false; 
				if type( scrollbar.onmouseleave ) == "table" then
					for _, f in pairs( scrollbar.onmouseleave ) do
						if type( f ) == "function" then
							f( scrollbar, x, y );
						end
					end
				end
			end, 
			false
		)

		return scrollbar;
	end
	return false;
end

--	Function: ScrollBar:ScrollPosition
--	Returns or sets the position of scrollbar.
--
--  Optional arguments:
--     amount - (integer) The position of scrollbar to set
--	   
--	Returns:
--	   Integer if tried to get, true or false if tried to set
function ScrollBar:ScrollPosition( amount )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( amount ) == "number" ) then
		return guiScrollBarSetScrollPosition( self.gui, amount );
	end
	return guiScrollBarGetScrollPosition( self.gui );
end

]])