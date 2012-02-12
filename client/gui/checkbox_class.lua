push([[
-----------------------------------------------------------
--- /client/gui/checkbox_class.lua                      ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: CheckBox Class
-- Class which allows to easily add checkboxes to windows/screen.
CheckBox = {  };
CheckBox.__index = CheckBox;

--	Function: CheckBox:Create
--	Creates a checkbox
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the checkbox
--     height - (float/integer) Height of the checkbox
--     text - (string) Text placed near the checkbox
--
--  Optional arguments:
--     selected - (bool) Is the checkbox selected?
--     relative - (bool) Are the x/y/width/height values relative?
--     parent - (GUI) Parent of the checkbox
--	   
--	Returns:
--		The result is checkbox object
function CheckBox:Create( x, y, width, height, text, selected, relative, parent )
	local checkbox = { 
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
		  ( i ~= "Dragable" )
		)
		then
			checkbox[ i ] = f;
		end
	end
--
	
	checkbox.gui = guiCreateCheckBox( x, y, width, height, text, selected, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( checkbox.gui ) then
		setmetatable( checkbox, self )
		self.__index = self;
		addEventHandler( "onClientMouseEnter", checkbox.gui, function( ) GUICollection.guiMouseIsOver = checkbox;  end, false );
		addEventHandler( "onClientMouseLeave", checkbox.gui, function( ) GUICollection.guiMouseIsOver = false;  end, false );
		addEventHandler( "onClientGUIClick", 
			checkbox.gui,
			function( mouseBtn, state, x, y )
				if type( checkbox.onclick ) == "table" then
					for i, f in pairs( checkbox.onclick ) do
						f( btn, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			checkbox.gui,
			function( x, y )
				if type( checkbox.onmouseenter ) == "table" then
					for _, f in pairs( checkbox.onmouseenter ) do
						if type( f ) == "function" then
							f( btn, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			checkbox.gui,
			function( x, y )
				if type( checkbox.onmouseleave ) == "table" then
					for _, f in pairs( checkbox.onmouseleave ) do
						if type( f ) == "function" then
							f( btn, x, y );
						end
					end
				end
			end, 
			false
		)

		return checkbox;
	end
	return false;
end

--	Function: CheckBox:Selected
--	Returns or sets the state of checkbox
--
--  Optional arguments:
--     selected - (bool) The state of checkbox to set
--	   
--	Returns:
--	   Boolean with checkbox state
function CheckBox:Selected( selected )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( selected ) == "boolean" ) then
		return guiCheckBoxSetSelected( self.gui, selected );
	end
	return guiCheckBoxGetSelected( self.gui );
end

]])