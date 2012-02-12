push([[
-----------------------------------------------------------
--- /client/gui/radiobutton_class.lua                   ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: RadioButton Class
-- Class which allows to easily add radiobuttons to windows/screen.
RadioButton = {  };
RadioButton.__index = RadioButton;

--	Function: RadioButton:Create
--	Creates a radiobutton
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the radiobutton
--     height - (float/integer) Height of the radiobutton
--     text - (string) Text placed near the radiobutton
--
--  Optional arguments:
--     selected - (bool) Is the checkbox selected?
--     relative - (bool) Are the x/y/width/height values relative?
--     parent - (GUI) Parent of the radiobutton
--	   
--	Returns:
--		The result is radiobutton object
function RadioButton:Create( x, y, width, height, text, selected, relative, parent )
	local radiobtn = {
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
			radiobtn[ i ] = f;
		end
	end
	
	radiobtn.gui = guiCreateRadioButton( x, y, width, height, text, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( radiobtn.gui ) then
		setmetatable( radiobtn, self );
		self.__index = self;
		
		if type( selected ) == "boolean" then
			radiobtn:Selected( selected );
		end
		
		addEventHandler( "onClientGUIClick", 
			radiobtn.gui,
			function( mouseBtn, state, x, y )
				if type( radiobtn.onclick ) == "table" then
					for i, f in pairs( radiobtn.onclick ) do
						f( radiobtn, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			radiobtn.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = radiobtn;
				if type( radiobtn.onmouseenter ) == "table" then
					for _, f in pairs( radiobtn.onmouseenter ) do
						if type( f ) == "function" then
							f( radiobtn, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			radiobtn.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = false; 
				if type( radiobtn.onmouseleave ) == "table" then
					for _, f in pairs( radiobtn.onmouseleave ) do
						if type( f ) == "function" then
							f( radiobtn, x, y );
						end
					end
				end
			end, 
			false
		)

		return radiobtn;
	end
	return false;
end

--	Function: RadioButton:Selected
--	Returns or sets the state of radiobutton.
--
--  Optional arguments:
--     selected - (bool) The state of radiobutton to set
--	   
--	Returns:
--	   Boolean with radiobutton's state
function RadioButton:Selected( selected )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( selected ) == "boolean" ) then
		return guiRadioButtonSetSelected( self.gui, selected );
	end
	return guiRadioButtonGetSelected( self.gui );
end
]])