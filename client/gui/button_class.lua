push([[
-----------------------------------------------------------
--- /client/gui/button_class.lua                        ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: Button Class
-- Class which allows to easily add buttons to windows/screen.
Button = {  };
Button.__index = Button;

--	Function: Button:Create
--	Creates a button
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the button
--     height - (float/integer) Height of the button
--     text - (string) Text placed on the button
--
--  Optional arguments:
--     relative - (bool) Are the x/y/width/height values relative?
--     parent - (GUI) Parent of the button
--	   
--	Returns:
--		The result is button object
function Button:Create( x, y, width, height, text, relative, parent )
	local btn =
	{ 
		gui = false,
		onclick = { },
		onmouseenter = { },
		onmouseleave = { },
		ontextchanged = { },
		cursorovergui = false,
		_dragable = false
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if( i ~= "__index" ) then
			btn[ i ] = f;
		end
	end
	
	btn.gui = guiCreateButton( x, y, width, height, text, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( btn.gui ) then
		setmetatable( btn, self );
		self.__index = self;
		addEventHandler( "onClientGUIClick", 
			btn.gui,
			function( mouseBtn, state, x, y )
				if type( btn.onclick ) == "table" then
					for i, f in pairs( btn.onclick ) do
						f( btn, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			btn.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = btn;
				if type( btn.onmouseenter ) == "table" then
					for _, f in pairs( btn.onmouseenter ) do
						if type( f ) == "function" then
							f( btn, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			btn.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = false;
				if type( btn.onmouseleave ) == "table" then
					for _, f in pairs( btn.onmouseleave ) do
						if type( f ) == "function" then
							f( btn, x, y );
						end
					end
				end
			end, 
			false
		)
		return btn;
	end
	return false;
end

--	Function: Button:ColorOnHover
--	Sets the color of text on button on hover.
--
--  Optional arguments:
--     hex - (string) Color to set
--	   
--	Returns:
--		* String with hex if the parameter was specified
--      * True if successfully set
--      * False if not
function Button:ColorOnHover( hex )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if hex then
		if ( type( hex ) == "string" ) and #hex == 8 then
			local alpha = string.sub( hex, 7, 8 );
			local RGB = string.sub( hex, 1, 6 );
			return guiSetProperty( self.gui, "HoverTextColour", alpha..RGB );
		end
		return false;
	end
	return guiGetProperty( self.gui, "HoverTextColour" );
end

--	Function: Button:AddOnTextChanged
--	Adds an function to execute when text on the button is changed.
--
--  Optional arguments:
--     func - (function) Function to add
--	   
--	Returns:
--      * True if successfully added
--      * False if not
function Button:AddOnTextChanged( func )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( func ) == "function" then
		table.insert( self.ontextchanged, func );
		return true;
	end
	return false;
end

--	Function: Button:RemoveOnTextChanged
--	Removes an function to execute when text on the button is changed.
--
--  Optional arguments:
--     func - (function) Function to remove
--	   
--	Returns:
--      * True if successfully removed
--      * False if not

function Button:RemoveOnTextChanged( func )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( func ) == "function" then
		for i, f in pairs( self.ontextchanged ) do
			if f == func then
				table.remove( self.ontextchanged, i );
				return true;
			end
		end
	end
	return false;
end

-------------------------------------------------



]])